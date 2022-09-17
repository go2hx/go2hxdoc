// The package documentation...
package main

import (
	"bytes"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"runtime"
	"strings"
	"sync"
	"time"

	"github.com/go2hx/go2hxdoc/haxedoc"
	"github.com/go2hx/go2hxdoc/packagedoc"
	"github.com/go2hx/go2hxdoc/rtti"
)

var tempDir string // set by the flags
var silent *bool   // set by the flags

func writeFile(filepath string, content []byte) {
	if !*silent {
		fmt.Println("Creating:", filepath)
	}
	err := os.WriteFile(filepath, content, 0666)
	if err != nil {
		panic(err)
	}
}

func main() {
	start := time.Now() // needed if -stats flag is used

	silent = flag.Bool("silent", false, "silence progress messages")

	stats := flag.Bool("stats", false, "show runtime statistics")

	flag.StringVar(&tempDir, "tmp", "./bin", "path to the temporary directory to use")

	var baseDir string
	flag.StringVar(&baseDir, "dir", "./golibs", "path to root directory of go2hx generated library (only tested for golibs and stdgo)")

	flag.Parse()

	if len(flag.Args()) > 0 {
		fmt.Println("Unrecognised command line arguments: ", flag.Args())
		flag.PrintDefaults()
		os.Exit(1) // unprocessed flags
	}

	// make the tempDir, if it does not already exist
	if err := os.MkdirAll(tempDir, 0777); err != nil {
		panic(err)
	}

	baseDir = filepath.Clean(baseDir)

	dirList := haxedoc.DirList(baseDir)

	// TODO flags to overide the above + set output MD format

	compilations := haxedoc.HaxeHxml(dirList, baseDir, tempDir)

	var wg sync.WaitGroup

	var finalCompilation haxedoc.HxmlXmlFiles

	compilationFunc := func(comp haxedoc.HxmlXmlFiles) {
		var libIndex []byte // contents of the library index file, if present
		var content []byte  // contents of the README file

		// run the haxe compiler
		//fmt.Println(comp.Hxml)
		cmd := exec.Command("haxe", comp.HxmlDoc)
		outBuf := bytes.Buffer{}
		cmd.Stdout = &outBuf
		errBuf := bytes.Buffer{}
		cmd.Stderr = &errBuf
		if err := cmd.Run(); err != nil {

			readmeFile := filepath.Join(comp.DP.CodeDir, "README.md")
			errorMD := []byte("# Module " + comp.Module + " has compilation errors, please do not use:\n```\n")
			errorMD = append(errorMD, errBuf.Bytes()...)
			errorMD = append(errorMD, outBuf.Bytes()...)

			libIndex, content = packagedoc.FileMD(rtti.DirData{}, comp.Module, string(append(errorMD, []byte("\n```\n")...)), comp.DP.IsRoot, true)
			writeFile(readmeFile, content)

			packagedoc.CompilationTestResults.Add(comp.Module, comp.DP.HasTest, false, nil)

		} else {

			testResultsMD := outBuf.String()
			resultsMap := map[string]bool{}
			if comp.DP.HasTest && len(comp.HxmlTests) > 0 {
				testResultsMD, resultsMap = haxedoc.RunTests(comp.HxmlTests, tempDir)
			}

			// read in the output from the Haxe compiler
			r, e := rtti.XMLread(comp.Xml)
			if e != nil {
				panic(e)
			}

			// now cut out what we don't need to show
			filtered, err := r.FilterBase(comp.DP.CodeDir, false) // just one dir + _test
			if err != nil {
				panic(err)
			}

			// pull out what needs to be shown by directory
			dirs, err := filtered.FindDirs()
			if err != nil {
				panic(err)
			}

			// go through the directories and add a markdown README.md - there should only be one
			for _, d := range dirs.DirList() {
				// first check the directory actually exists
				entries, err := os.ReadDir(d)
				if err != nil {
					panic(err)
				}
				if len(entries) == 0 {
					panic(fmt.Errorf("no files in target directory %s", d))
				}
				readmeFile := filepath.Join(d, "README.md")
				libIndex, content = packagedoc.FileMD(dirs[d], comp.Module, testResultsMD, comp.DP.IsRoot, false)

				writeFile(readmeFile, content)
				packagedoc.CompilationTestResults.Add(comp.Module, comp.DP.HasTest, true, resultsMap)

			}
		}
		if libIndex != nil {
			codeDirParts := strings.Split(comp.DP.CodeDir, "/")
			writeFile(filepath.Join(comp.DP.CodeDir, codeDirParts[len(codeDirParts)-1]+".md"), libIndex)
		}
		if !comp.DP.IsRoot {
			wg.Done()
		}
	}

	if len(compilations) > 0 {
		for _, comp := range compilations {
			if comp.DP.IsRoot {
				finalCompilation = comp
			} else {
				wg.Add(1)
				if *haxedoc.Seq {
					compilationFunc(comp)
				} else {
					go compilationFunc(comp)
				}
			}
		}
		wg.Wait()

		packagedoc.CompilationTestResults.Sort()
		compilationFunc(finalCompilation)
	}

	if *stats {
		var ms runtime.MemStats
		runtime.ReadMemStats(&ms)
		fmt.Printf("TotalAlloc: %.1fMb\n", float64(ms.TotalAlloc)/(1024.0*1024.0))
		fmt.Println("Duration: " + time.Since(start).String())
	}
}
