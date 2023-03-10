// Packagedoc creates a markdown page for a given package.
// It emulates the Go documentation format:
// - Overview
// - Index
// - Examples
// - Constants
// - Variables
// - Functions
// - Types
package packagedoc

import (
	"bytes"
	"fmt"
	"path/filepath"
	"sort"
	"strings"
	"sync"
	"unicode"
	"unicode/utf8"

	"github.com/go2hx/go2hxdoc/extractfunc"
	"github.com/go2hx/go2hxdoc/haxedoc"
	"github.com/go2hx/go2hxdoc/rtti"
	"github.com/princjef/gomarkdoc/format"
)

type Result struct {
	Module       string
	HasTest      bool
	CompiledOK   bool
	TargetTestOK map[string]bool
}

type GlobalResults struct {
	mux     sync.Mutex
	Results []Result
}

func (gr *GlobalResults) Add(module string, hasTest, ok bool, targetTestOK map[string]bool) {
	gr.mux.Lock()
	gr.Results = append(gr.Results, Result{Module: module, HasTest: hasTest, CompiledOK: ok, TargetTestOK: targetTestOK})
	gr.mux.Unlock()
}

func (gr *GlobalResults) Sort() {
	gr.mux.Lock()
	sort.Slice(gr.Results, func(i, j int) bool {
		return gr.Results[i].Module < gr.Results[j].Module
	})
	gr.mux.Unlock()
}

var CompilationTestResults = new(GlobalResults)

type Config struct {
	MD  format.Format
	Out bytes.Buffer
	FE  extractfunc.FuncExtractor
}

func (cfg *Config) Header(level int, text string) {
	txt, err := cfg.MD.Header(level, text)
	if err != nil {
		panic(err)
	}
	fmt.Fprintln(&cfg.Out, txt)
}

func (cfg *Config) ListEntry(level int, text string) {
	txt, err := cfg.MD.ListEntry(level, text)
	if err != nil {
		panic(err)
	}
	fmt.Fprintln(&cfg.Out, txt)
}

func (cfg *Config) CodeBlock(text string) {
	txt, err := cfg.MD.CodeBlock("haxe", text)
	if err != nil {
		panic(err)
	}
	fmt.Fprintln(&cfg.Out, txt)
}

func (cfg *Config) CommentPara(text string, headingLevel int) {
	text = strings.TrimRightFunc(text, func(r rune) bool {
		return unicode.IsSpace(r) // remove whitespace
	})
	if len(text) == 0 {
		return
	}
	{ // generate Go subheading if required
		testHeading := strings.TrimLeftFunc(text, func(r rune) bool {
			return unicode.IsSpace(r) // remove whitespace
		})
		if strings.HasPrefix(testHeading, "# ") {
			cfg.Header(headingLevel, testHeading[2:])
			return
		}
	}

	text = "```\n" + text + "\n```" // a code block - hand coded
	fmt.Fprintln(&cfg.Out, text)
}

func (cfg *Config) Comment(text string, headingLevel int) {
	para := ""
	blankCount := 0
	for _, line := range strings.Split(text, string(utf8.RuneError)) {
		if line == "" {
			blankCount++
			if blankCount > 3 && para != "" { // probably a blank line between two sets of free-form text
				para = ""
				blankCount = 0
			}
		} else {
			blankCount = 0

			oldLine := line
			line = strings.TrimSpace(line) // remove leading and trailing whitespace
			if len(line) >= 2 {            // remove leading comment markers, if present
				switch line[:2] {
				case "/|":
					if len(line) >= 3 && line[2] == '*' {
						line = line[3:]
					}
				case "//", "/*":
					line = line[2:]
				default:
					line = oldLine // otherwise reinstate the original line's leading spacing
				}
			}

			// remove trailing comment markers, if present
			line = strings.TrimSuffix(line, "*/")
			line = strings.TrimSuffix(line, "*|/")

			if line == "" { // we must be between paragraphs
				cfg.CommentPara(para, headingLevel)
				para = ""
			} else {
				para += line + "  \n" // two spaces at the end of a line should be interpreted by GitHub as a <br />
			}
		}
	}
	cfg.CommentPara(para, headingLevel)
}

func (cfg *Config) Example(ex *rtti.Example) {
	cfg.Header(3, ex.Name)
	txt, err := cfg.MD.AccordionHeader("")
	if err != nil {
		panic(err)
	}
	fmt.Fprintln(&cfg.Out, txt)
	cfg.CodeBlock(string(cfg.FE.GetExample(ex)))
	txt, err = cfg.MD.AccordionTerminator()
	if err != nil {
		panic(err)
	}
	fmt.Fprintln(&cfg.Out, txt)
}

func (cfg *Config) Write(txt string) {
	fmt.Fprintln(&cfg.Out, txt)
}

func (cfg *Config) Link(text, href string) string {
	if text[0] != '`' {
		text = cfg.MD.Escape(text)
	}
	txt, err := cfg.MD.Link(text, href)
	if err != nil {
		panic(err)
	}
	return txt
}

func (cfg *Config) LocalHref(href string) string {
	txt, err := cfg.MD.LocalHref(href)
	if err != nil {
		panic(err)
	}
	return txt
}

func (cfg *Config) CodeHref(file string, line uint) string {
	// TODO consider use of MD package version
	_, fname := filepath.Split(file)
	if line == 0 {
		// link just to the file, not including the line
		return fmt.Sprintf("./%s", fname)
	}
	return fmt.Sprintf("./%s#L%d", fname, line)
}

func FileMD(dd rtti.DirData, module, stdout string, showGlobalResults, hadError bool) (libIndex, readme []byte) { // TODO return err

	cfg := Config{
		MD:  new(format.GitHubFlavoredMarkdown),
		Out: bytes.Buffer{},
	}

	if showGlobalResults {

		// local version of cfg
		cfg := Config{
			MD:  new(format.GitHubFlavoredMarkdown),
			Out: bytes.Buffer{},
		}

		cfg.Header(1, "Library compilation and test results")
		line := `| module | compile | tests |`
		for _, target := range haxedoc.Targets {
			if haxedoc.TargetsUsed[target] {
				line += " " + target + ` |`
			}
		}
		cfg.Write(line)
		line = `| --- | --- | --- | `
		for _, target := range haxedoc.Targets {
			if haxedoc.TargetsUsed[target] {
				line += ` --- |`
			}
		}
		cfg.Write(line)

		lastModule := ""
		for _, r := range CompilationTestResults.Results {
			if r.Module != lastModule {
				lastModule = r.Module
				tests := "no"
				if r.HasTest {
					tests = "yes"
				}
				pf := "❌"
				if r.CompiledOK {
					pf = "✅"
				}

				moduleLink := strings.ReplaceAll(r.Module, ".", "/") + "/README.md"
				moduleLink = strings.TrimPrefix(moduleLink, "stdgo/") // stdgo directory is the first part of the module name
				moduleLink = "./" + moduleLink

				line := fmt.Sprintf("| [%s](%s) | %s | %s |", r.Module, moduleLink, pf, tests)
				for _, t := range haxedoc.Targets {
					if haxedoc.TargetsUsed[t] {
						if r.HasTest {
							passed, exists := r.TargetTestOK[t]
							if exists {
								disp := "❌"
								if passed {
									disp = "✅"
								}
								line += fmt.Sprintf(" %s |", disp)
							} else {
								line += "  |"
							}
						} else {
							line += "  |"
						}
					}
				}
				cfg.Write(line)
			}
		}
		cfg.Write("") // blank line

		libIndex = cfg.Out.Bytes()
	}

	if hadError {
		cfg.Write(stdout)
		return libIndex, cfg.Out.Bytes()
	}

	overallModule := ""
	if dd.ModuleLevel.Class != nil {
		modParts := strings.Split(dd.ModuleLevel.Class.Module, ".")
		overallModule = strings.Join(modParts[:len(modParts)-1], ".") + ".*" // remove the final filename and replace with ".*""
	}

	const (
		overview int = iota
		index
		examples
		constants
		variables
		functions
		classes
		typedefs
		abstracts
	)

	headers := []string{
		"Overview",
		"Index",
		"Examples",
		"Constants",
		"Variables",
		"Functions",
		"Classes",
		"Typedefs",
		"Abstracts",
	}

	classMethodSeparator := " function " // many other special characters have been tried here, but only space seems to work.

	cfg.Write("# Module: `" + module + "`\n")

	{ // link back to the top index
		var overallIndexLink string
		modParts := strings.Split(module, ".")
		switch modParts[0] {
		case "stdgo":
			overallIndexLink = modParts[0] + ".md"
			if modParts[0] == "stdgo" {
				modParts = modParts[1:] // stdgo needs one fewer ../
			}
		default:
			overallIndexLink = "golibs.md"
		}
		if len(modParts) == 0 || module == "Main" || // TODO document it relies on the top level always being called "Main"
			module == "stdgo.Go" {
			overallIndexLink = "./" + overallIndexLink
		} else {
			for i := 0; i < len(modParts); i++ {
				overallIndexLink = "../" + overallIndexLink
			}
		}

		cfg.Write(fmt.Sprintf("[(view library index)](%s)\n\n", overallIndexLink))
	}

	cfg.Header(1, headers[overview])
	{
		cfg.Comment(dd.Doc, 2)
		if dd.TestModule != "" {
			fmt.Fprintln(&cfg.Out, stdout)
		}
	}

	cfg.Header(1, headers[index])
	{
		if len(dd.ModuleLevel.Constants) > 0 {
			cfg.ListEntry(0, cfg.Link(headers[constants], cfg.LocalHref(headers[constants])))
		}
		if len(dd.ModuleLevel.Variables) > 0 {
			cfg.ListEntry(0, cfg.Link(headers[variables], cfg.LocalHref(headers[variables])))
		}
		for _, fn := range dd.ModuleLevel.Functions {
			cfg.ListEntry(0, cfg.Link("`"+fn.String()+"`", cfg.LocalHref("function "+fn.XMLName.Local)))
		}
		for _, cl := range dd.Classes {
			cfg.ListEntry(0, cfg.Link("class "+cl.Class.Name(), cfg.LocalHref("class "+cl.Class.Name())))
			for _, fn := range cl.Functions {
				fnSig := fn.String()                         // this is needed if an anonymous structure is returned
				fnSig = strings.ReplaceAll(fnSig, "\t", " ") // replace tabs with spaces
				fnSig = strings.ReplaceAll(fnSig, "\n", "")  // remove newlines
				cfg.ListEntry(1, cfg.Link("`"+fnSig+"`", cfg.LocalHref(cl.Class.Name()+classMethodSeparator+fn.XMLName.Local)))
			}
		}
		for _, cd := range dd.Typedefs {
			cfg.ListEntry(0, cfg.Link("typedef "+cd.Typedef.Name(), cfg.LocalHref("typedef "+cd.Typedef.Name())))
		}
		for _, ab := range dd.Abstracts {
			cfg.ListEntry(0, cfg.Link("abstract "+ab.Abstract.Name(), cfg.LocalHref("abstract "+ab.Abstract.Name())))
		}
	}

	// examples
	if len(dd.Examples) > 0 {
		cfg.Header(1, headers[examples])
		for _, ex := range dd.Examples {
			cfg.ListEntry(0, cfg.Link("`"+ex.Name+"`", cfg.LocalHref(ex.Name)))
		}
	}

	// constants
	if len(dd.ModuleLevel.Constants) > 0 {
		cfg.Header(1, headers[constants])
		cfg.CodeBlock("import " + dd.ModuleLevel.Class.Module)
		if len(dd.ModuleLevel.Constants) > 0 {
			for _, v := range dd.ModuleLevel.Constants {
				cfg.CodeBlock(v.String() + " = " + v.Expr)
				if len(v.Doc) > 0 {
					cfg.Comment(v.Doc, 2)
				}
			}
		}
	}

	// variables
	if len(dd.ModuleLevel.Variables) > 0 {
		cfg.Header(1, headers[variables])
		cfg.CodeBlock("import " + dd.ModuleLevel.Class.Module)
		for _, v := range dd.ModuleLevel.Variables {
			cfg.CodeBlock(v.String())
			if len(v.Doc) > 0 {
				cfg.Comment(v.Doc, 2)
			}
		}
	}

	// functions
	if len(dd.ModuleLevel.Functions) > 0 {
		cfg.Header(1, headers[functions])
		cfg.CodeBlock("import " + dd.ModuleLevel.Class.Module)
		for _, fn := range dd.ModuleLevel.Functions {
			cfg.Header(2, "function "+fn.XMLName.Local)
			cfg.CodeBlock(fn.String())
			cfg.Comment(fn.Doc, 3)
			for _, ex := range fn.Examples {
				cfg.Example(&ex)
			}
			cfg.Write(cfg.Link("(view code)", cfg.CodeHref(dd.ModuleLevel.Class.File, fn.Line)) + "\n\n")
		}
	}

	// classes
	if len(dd.Classes) > 0 {
		cfg.Header(1, headers[classes])
		cfg.CodeBlock("import " + overallModule)

		for _, cd := range dd.Classes {
			cfg.Header(2, "class "+cd.Class.Name())
			cfg.Comment(cd.Class.Doc, 3)

			for _, v := range cd.Variables {
				cfg.CodeBlock(v.String())
				if len(v.Doc) > 0 {
					cfg.Comment(v.Doc, 3)
				}
			}

			for _, fn := range cd.Functions {
				cfg.Header(3, cd.Class.Name()+classMethodSeparator+fn.XMLName.Local)
				cfg.CodeBlock(fn.String())
				cfg.Comment(fn.Doc, 4)
				if cd.Class.File != "" && fn.Line != 0 {
					cfg.Write(cfg.Link("(view code)", cfg.CodeHref(cd.Class.File, fn.Line)) + "\n\n")
				}
			}

		}
	}

	// typedefs
	if len(dd.Typedefs) > 0 {
		cfg.Header(1, headers[typedefs])
		cfg.CodeBlock("import " + overallModule)

		for _, cd := range dd.Typedefs {
			cfg.Header(2, "typedef "+cd.Typedef.Name())
			code := "typedef " + cd.Typedef.Name() + " = "
			for _, fld := range cd.Typedef.Fields {
				code += fld.String() + ";\n"
			}

			cfg.CodeBlock(code)

			cfg.Comment(cd.Typedef.Doc, 3)
		}
	}

	// abstracts
	if len(dd.Abstracts) > 0 {
		cfg.Header(1, headers[abstracts])
		for _, ab := range dd.Abstracts {
			cfg.Header(2, "abstract "+ab.Abstract.Name())
			if ab.Abstract.Doc != "" {
				cfg.Comment(ab.Abstract.Doc, 3)
			}
			cfg.Write(cfg.Link("(view file containing code)", cfg.CodeHref(ab.Abstract.File, 0)) + "\n\n")
		}
	}

	return libIndex, cfg.Out.Bytes()
}
