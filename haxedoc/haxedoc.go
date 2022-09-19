// haxedoc uses haxe to generate the documentan xml for the given directory tree
package haxedoc

import (
	"bytes"
	"context"
	"flag"
	"fmt"
	"os"
	"os/exec"
	"path"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"time"
	"unicode"

	"github.com/princjef/gomarkdoc/format"
)

// var target string // set by flag code below
var Seq *bool                // set by flag code below
var Force *bool              // set by flag code below
var timeLimit *time.Duration // set by flag code below
var interpFlag *bool         // set by flag code below
var hlFlag *bool             // set by flag code below
var cppFlag *bool            // set by flag code below
var jvmFlag *bool            // set by flag code below
var CmdPrefix string         // set by flag code below

func init() {
	// flag.StringVar(&target, "target", "interp", "testing target(s): 'interp', 'hl', 'cpp', 'jvm', or 'all'") // TODO !
	Seq = flag.Bool("seq", false, "run the documentation build and tests sequentially to lower peak resource usage")
	Force = flag.Bool("force", false, "force the documentation build, even when it seems up-to-date")

	timeLimit = flag.Duration("timeout", 2*time.Minute, "time limit for individual module tests' compile/run")

	interpFlag = flag.Bool("interp", false, "run the tests using Haxe interp")
	hlFlag = flag.Bool("hl", false, "run the tests using HashLink")
	cppFlag = flag.Bool("cpp", false, "run the tests using C++")
	jvmFlag = flag.Bool("jvm", false, "run the tests using the JVM")

	flag.StringVar(&CmdPrefix, "prefix", "", "prefix for CLI commands (when using lix: '-prefix npx')")
}

func IsTest() bool {
	return *interpFlag || *hlFlag || *cppFlag || *jvmFlag
}

var Targets = []string{"cpp", "hl", "interp", "jvm"} // in lexical order

type DirPair struct {
	CodeDir string
	HasTest bool
	IsRoot  bool
}

func DirList(baseDir string) []DirPair {
	baseDir = filepath.Clean(baseDir)
	dirsInTree := map[string]bool{}
	err := filepath.Walk(baseDir,
		func(path string, info os.FileInfo, err error) error {
			if err != nil {
				panic(err)
			}
			if info.IsDir() {
				entries, err := os.ReadDir(path)
				if err != nil {
					panic(err)
				}

				var latestHX, latestMD time.Time
				var hadHX, hadMD bool
				for _, ent := range entries {
					info, err := ent.Info()
					if err != nil {
						panic(err)
					}
					parts := strings.Split(ent.Name(), ".")
					switch parts[len(parts)-1] {
					case "hx":
						if !hadHX {
							latestHX = info.ModTime()
							hadHX = true
						} else {
							if latestHX.Before(info.ModTime()) {
								latestHX = info.ModTime()
							}
						}
					case "md":
						if !hadMD {
							latestMD = info.ModTime()
							hadMD = true
						} else {
							if latestMD.Before(info.ModTime()) {
								latestMD = info.ModTime()
							}
						}
					}
				}
				// fmt.Println(path, "HX", hadHX, latestHX, "MD", hadMD, latestMD, latestMD.Before(latestHX)) // debug
				if hadHX {
					if hadMD {
						if latestMD.Before(latestHX) || *Force || IsTest() { // TODO put test results into central JSON in order to skip if already done
							dirsInTree[path] = true
						}
					} else {
						dirsInTree[path] = true
					}
				}
			}
			return nil
		})
	if err != nil {
		panic(err)
	}

	ret := make([]DirPair, 0, len(dirsInTree))
	for d := range dirsInTree {
		if !strings.HasSuffix(d, "_test") {
			this := DirPair{CodeDir: d}
			if d == baseDir {
				this.IsRoot = true // at root of directory tree
			}
			testDir := d + "_test"
			this.HasTest = dirsInTree[testDir]
			ret = append(ret, this)
		}
	}
	sort.Slice(ret, func(i, j int) bool {
		return ret[i].CodeDir < ret[j].CodeDir
	})

	return ret
}

type HxmlXmlFiles struct {
	HxmlDoc, Xml, Module string
	HxmlTests            map[string]string
	DP                   DirPair
}

func HaxeHxml(dirPairs []DirPair, baseDir, tempDir string) []HxmlXmlFiles {
	ret := make([]HxmlXmlFiles, 0, len(dirPairs))
	for _, d := range dirPairs {
		baseDirParts := strings.Split(baseDir, "/")
		baseModule := baseDirParts[len(baseDirParts)-1]
		module := strings.TrimPrefix(d.CodeDir, baseDir)
		if len(module) == 0 {
			module = baseModule
		} else {
			module = baseModule + strings.Join(strings.Split(module, "/"), ".")
		}
		//fmt.Println(d, baseDir, baseModule, module)

		// when developing locally (rather than stdgo) the top level dir does not form part of the path
		module = strings.TrimPrefix(module, "golibs") // TODO this is a horrible kludge, find a better way to do this!
		module = strings.TrimPrefix(module, ".")      // TODO this is a horrible kludge, find a better way to do this!
		if len(module) == 0 {                         // this is actually a program, so we need to find the entry point
			entries, err := os.ReadDir(d.CodeDir)
			if err != nil {
				panic(err)
			}
			for _, ent := range entries {
				if strings.HasSuffix(ent.Name(), ".hx") {
					module += strings.TrimSuffix(ent.Name(), ".hx") // only one file per go2hx program
					break
				}
			}
		}
		if module == "stdgo" {
			module += ".Go"
		}

		tempFilePrefix := path.Join(tempDir, strings.ReplaceAll(module, ".", "_"))

		this := HxmlXmlFiles{
			Xml:       tempFilePrefix + ".xml",
			HxmlDoc:   tempFilePrefix + "-doc.hxml",
			HxmlTests: map[string]string{},
			Module:    module,
			DP:        d,
		}

		hxmlCommon := "-cp " + baseDir + "\n"
		hxmlCommon += "-lib go2hx\n"
		hxmlCommon += module + "\n"
		if d.HasTest {
			hxmlCommon += module + "_test\n"
			moduleElements := strings.Split(module, ".")
			runes := []rune(moduleElements[len(moduleElements)-1])
			runes[0] = unicode.ToUpper(runes[0])
			hxmlCommon += "-m " + module + "_test." + string(runes) + "\n"
		}

		hxmlDoc := hxmlCommon + "-D doc-gen\n-dce no\n--no-output\n-neko dummy.n\n-xml " + this.Xml + "\n"
		err := os.WriteFile(this.HxmlDoc, []byte(hxmlDoc), 0666)
		if err != nil {
			panic(err)
		}

		if d.HasTest {
			//interp
			if *interpFlag {
				file := tempFilePrefix + "-interp.hxml"
				content := hxmlCommon + "--interp\n"
				err := os.WriteFile(file, []byte(content), 0666)
				if err != nil {
					panic(err)
				}
				this.HxmlTests["interp"] = file
			}
			//jvm
			if *jvmFlag {
				file := tempFilePrefix + "-jvm.hxml"
				content := hxmlCommon + "--jvm " + tempFilePrefix + ".jvm\n"
				content += "--cmd java -jar " + tempFilePrefix + ".jvm\n"
				err := os.WriteFile(file, []byte(content), 0666)
				if err != nil {
					panic(err)
				}
				this.HxmlTests["jvm"] = file
			}
			//hl
			if *hlFlag {
				file := tempFilePrefix + "-hl.hxml"
				content := hxmlCommon + "--hl " + tempFilePrefix + ".hl\n"
				content += "--cmd hl " + tempFilePrefix + ".hl\n"
				err := os.WriteFile(file, []byte(content), 0666)
				if err != nil {
					panic(err)
				}
				this.HxmlTests["hl"] = file
			}
			//cpp
			if *cppFlag {
				exeParts := strings.Split(module, ".")
				exeRunes := []rune(exeParts[len(exeParts)-1])
				if len(exeRunes) > 1 {
					exeRunes[0] = unicode.ToUpper(exeRunes[0])
					file := tempFilePrefix + "-cpp.hxml"
					content := hxmlCommon
					content += "--cpp " + tempDir + "/hxcpp_common\n" // put all the cpp code in the same dir, to reuse common objects
					content += "--cmd " + tempDir + "/hxcpp_common/" + string(exeRunes) + "\n"
					err := os.WriteFile(file, []byte(content), 0666)
					if err != nil {
						panic(err)
					}
					this.HxmlTests["cpp"] = file
				}
			}
		}
		ret = append(ret, this)
	}
	return ret
}

var cpp1st sync.Once  // first time through for cpp, to allow longer processing time for compilation
var cppMux sync.Mutex // needs to be global, as all cpp processing must be done serially to reuse the common compilation cache
//var hlMux sync.Mutex  // needs to be global, as all hl processing must be done serially - TODO true?
//var jvmMux sync.Mutex // needs to be global, as all jvm processing must be done serially - TODO true?

func RunTests(tests map[string]string, tempDir string) (markdown string, results map[string]bool) {
	results = map[string]bool{}
	outputMap := map[string][]byte{}
	var wg sync.WaitGroup
	var mtx sync.Mutex
	MD := new(format.GitHubFlavoredMarkdown)

	doIt := func(target, hxml string) {

		thisTimeLimit := *timeLimit
		switch target {
		case "cpp":
			cppMux.Lock()
			cpp1st.Do(func() {
				thisTimeLimit *= 3 // allow a very long time for the first C++ compilation
			})
		case "hl":
			//hlMux.Lock()
		case "jvm":
			//jvmMux.Lock()
		}

		ctx, cancel := context.WithTimeout(context.Background(), thisTimeLimit)
		defer func() { // will run at the end, whatever happens
			cancel()
			wg.Done()
			switch target {
			case "cpp":
				cppMux.Unlock()
			case "hl":
				//hlMux.Unlock()
			case "jvm":
				//jvmMux.Unlock()
			}
		}()

		cmd := exec.CommandContext(ctx, CmdPrefix+"haxe", hxml)
		outBuf := bytes.Buffer{}
		cmd.Stdout = &outBuf
		errBuf := bytes.Buffer{}
		cmd.Stderr = &errBuf

		if err := cmd.Run(); err != nil {
			mtx.Lock()
			results[target] = false
			output := append(errBuf.Bytes(), outBuf.Bytes()...)
			if len(output) == 0 {
				output = []byte(fmt.Sprintf("(Test time-out - runtime exceeded %s)\n", timeLimit.String()))
			}
			outputMap[target] = output
			mtx.Unlock()
		} else {
			mtx.Lock()
			results[target] = true
			outputMap[target] = outBuf.Bytes()
			mtx.Unlock()
		}
	}

	for target, hxml := range tests {
		wg.Add(1)
		if *Seq {
			doIt(target, hxml)
		} else {
			go doIt(target, hxml)
		}
	}
	wg.Wait()

	// TODO markdown
	for _, t := range Targets {
		pass, exists := results[t]
		var str string
		var err error
		if exists {
			if pass {
				str, err = MD.AccordionHeader(t + " tests passed")
			} else { //fail
				str, err = MD.AccordionHeader(t + " tests failed")
			}
			if err != nil {
				panic(err)
			}
			markdown += str
			markdown += "```\n"
			if pass {
				// if we have passed, loose any compilation noise before results
				run := []byte("=== RUN")
				parts := bytes.Split(outputMap[t], run)
				if len(parts) > 1 {
					parts = parts[1:]
				}
				markdown += string(append(run, bytes.Join(parts, run)...))
			} else {
				markdown += string(outputMap[t])
			}
			markdown += "```\n"
			str, err = MD.AccordionTerminator()
			if err != nil {
				panic(err)
			}
			markdown += str
		}
	}
	return
}
