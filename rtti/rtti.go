// Package rtti decodes the xml file created by the Haxe compiler containing the Run Time Typo Information.
// The Run Time Type Information (RTTI) is emitted by the Haxe compiler if the -xml command line flag is used.
// See: https://haxe.org/manual/cr-rtti.html for an introduction
// API: https://api.haxe.org/haxe/rtti/TypeTree.html
// Many type names in this package are intended to be the same as in the API above
package rtti

import (
	"encoding/xml"
	"fmt"
	"os"
	"path/filepath"
	"sort"
	"strings"
	"unicode"
)

type M struct {
	N string `xml:"n,attr"`
	E string `xml:"e"`
}

type Meta struct {
	Metas []M `xml:"m"`
}

func (m *Meta) Using() string {
	for _, item := range m.Metas {
		if item.N == ":using" {
			parts := strings.Split(item.E, ".") // item.E is a Haxe path
			return parts[len(parts)-1]          // we only want the class name
		}
	}
	return ""
}

type TAbstractdecl struct {
	Path     string `xml:"path,attr"`
	Params   string `xml:"params,attr"`
	File     string `xml:"file,attr"`
	Private  bool   `xml:"private,attr"`
	Module   string `xml:"module,attr"`
	MetaInfo Meta   `xml:"meta"`
	This     CField `xml:"this"`
	Doc      string `xml:"haxe_doc"`
}

type Type struct { // amalgum of Haxe types
	XMLName xml.Name
	Path    string `xml:"path,attr"`
	Args    string `xml:"a,attr"`
	Wraps   []Type `xml:",any"`
}

func (t *Type) String() string {
	switch t.XMLName.Local {
	case "f": // function
		ret := "("
		if t.Args != "" {
			argNames := strings.Split((t.Args), ":")
			comma := ""
			for i, n := range argNames {
				ret += comma + n + ":" + t.Wraps[i].String()
				comma = ", "
			}
			ret += ")"
			if len(t.Wraps) > len(argNames) {
				ret += ":" + t.Wraps[len(argNames)].String()
			}
		} else {
			ret += ")"
			if len(t.Wraps) == 1 {
				ret += ":" + t.Wraps[0].String()
			}
		}

		return ret

	case "a": // anonymous structure
		ret := "{"
		comma := ""
		for _, w := range t.Wraps {
			ret += comma + w.String()
			comma = ", "
		}
		return ret + "}"

	case "e", "c", "t", "x":
		if len(t.Wraps) == 0 {
			return t.Path
		}
		ret := t.Path + "<"
		comma := ""
		for _, w := range t.Wraps {
			ret += comma + w.String()
			comma = ", "
		}
		return ret + ">"

	case "d":
		return "Dynamic"

	default: // elements of an anonymous structure or "unknown" or error
		if len(t.Wraps) == 1 {
			// it is probably an anonymous structure element
			return t.XMLName.Local + ":" + t.Wraps[0].String()
		}
		wraps := ""
		for _, w := range t.Wraps {
			wraps += " | " + w.String()
		}
		args := ""
		if t.Args != "" {
			args = "(" + t.Args + ")"
		}
		return "{" + t.Path + args + "<" + t.XMLName.Local + ">" + wraps + "}"
	}
}

type Example struct {
	Name string
	File string
	Line uint
}

type CField struct {
	XMLName        xml.Name
	Params         string    `xml:"params,attr"`
	Get            string    `xml:"get,attr"`
	Set            string    `xml:"set,attr"`
	Line           uint      `xml:"line,attr"`
	Static         bool      `xml:"static,attr"`
	Public         bool      `xml:"public,attr"`
	Final          bool      `xml:"final,attr"`
	Expr           string    `xml:"expr,attr"`
	Doc            string    `xml:"haxe_doc"`
	MetaInfo       Meta      `xml:"meta"`
	TypeInfo       Type      `xml:",any"`
	File           string    // needed for the file of the examples
	TypeIs1stParam bool      // for use with fields of classes mentioned in ":using" metadata
	Examples       []Example // from the _test dir, if present
}

func (f *CField) Declaration() string {
	switch f.TypeInfo.XMLName.Local {
	case "f":
		return "function"
	default:
		if f.Final && f.Expr != "" {
			return "final"
		} else {
			return "var"
		}
	}
}

func (f *CField) String() string {
	typeString := f.TypeInfo.String()
	sp := ":"
	decl := f.Declaration()
	if decl == "function" {
		sp = ""

		if f.TypeIs1stParam { // must remove the 1st param - TODO check it works for Generic types as 1st param
			var TSrunes []rune
			part := 0
			for _, r := range typeString {
				switch part {
				case 0: // first part of the call sig
					TSrunes = append(TSrunes, r)
					if r == '(' {
						part = 1
					}
				case 1: // the part of the sig we need to remove
					switch r {
					case ')':
						TSrunes = append(TSrunes, r)
						fallthrough
					case ',':
						part = 2
					default: // drop the rune
					}
				case 2: // the part after the first parameter
					TSrunes = append(TSrunes, r)
				}
			}
			typeString = string(TSrunes)
		}

	}
	return decl + " " + f.XMLName.Local + sp + typeString
}

type TClassdecl struct {
	Path     string   `xml:"path,attr"`
	Params   string   `xml:"params,attr"`
	File     string   `xml:"file,attr"`
	Line     uint     `xml:"line,attr"`
	Private  bool     `xml:"private,attr"`
	Module   string   `xml:"module,attr"`
	Final    bool     `xml:"final,attr"`
	MetaInfo Meta     `xml:"meta"`
	Doc      string   `xml:"haxe_doc"`
	Fields   []CField `xml:",any"`
}

func (tc *TClassdecl) Name() string {
	pathParts := strings.Split(tc.Path, ".")
	return pathParts[len(pathParts)-1]
}

func (tc *TClassdecl) SortFields() { // also set file in Fields
	sort.Slice(tc.Fields, func(i, j int) bool {
		return tc.Fields[i].XMLName.Local < tc.Fields[j].XMLName.Local
	})
}

type TTypedecl struct {
	Path     string   `xml:"path,attr"`
	Params   string   `xml:"params,attr"`
	File     string   `xml:"file,attr"`
	Private  bool     `xml:"private,attr"`
	Module   string   `xml:"module,attr"`
	MetaInfo Meta     `xml:"meta"`
	Doc      string   `xml:"haxe_doc"`
	Fields   []CField `xml:",any"`
}

func (ty *TTypedecl) Name() string {
	pathParts := strings.Split(ty.Path, ".")
	return pathParts[len(pathParts)-1]
}

type TEnumdecl struct { // GO2HX does not emit Enums as part of the public API
	Path    string `xml:"path,attr"`
	Params  string `xml:"params,attr"`
	File    string `xml:"file,attr"`
	Private bool   `xml:"private,attr"`
	Module  string `xml:"module,attr"`
}

type Other struct {
	XMLName xml.Name
}

type TypeTree struct {
	XMLName xml.Name `xml:"haxe"`
	//Packages  []TPackage  `xml:"package"` - never seen in the wild
	Abstracts []TAbstractdecl `xml:"abstract"`
	Classes   []TClassdecl    `xml:"class"`
	Typedefs  []TTypedecl     `xml:"typedef"`
	Enums     []TEnumdecl     `xml:"enum"`
	Others    []Other         `xml:",any"` // just in case we've missed something
}

func (tt *TypeTree) FindClass(file, name string) *TClassdecl {
	if file == "" || name == "" {
		return nil
	}
	for k, v := range tt.Classes {
		if file == v.File && strings.HasSuffix(v.Path, name) {
			return &tt.Classes[k]
		}
	}
	return nil
}

func isThisDir(file, base string, incSubDirs bool) bool {
	dir := filepath.Dir(file)
	if incSubDirs {
		return strings.HasPrefix(dir, base)
	} else {
		return dir == base || dir == base+"_test"
	}
}

func (tt *TypeTree) FilterBase(base string, incSubDirs bool) (*TypeTree, error) {

	base = filepath.Clean(base) // get rid of any leading "./"

	var ret TypeTree
	ret.XMLName = tt.XMLName
	for _, v := range tt.Abstracts {
		if isThisDir(v.File, base, incSubDirs) {
			ret.Abstracts = append(ret.Abstracts, v)
			//fmt.Println("filter in", v)
		}
	}
	for k, v := range tt.Classes {
		if isThisDir(v.File, base, incSubDirs) {
			for i := range v.Fields { // put the actual file in the fields for reporting
				tt.Classes[k].Fields[i].File = tt.Classes[k].File
			}
			ret.Classes = append(ret.Classes, v)
			//fmt.Println("filter in", v)
		}
	}
	for _, v := range tt.Typedefs {
		if isThisDir(v.File, base, incSubDirs) {
			//fmt.Println("filter in", v)
			ret.Typedefs = append(ret.Typedefs, v)
		}
	}
	for _, v := range tt.Enums {
		if isThisDir(v.File, base, incSubDirs) {
			ret.Enums = append(ret.Enums, v)
			//fmt.Println("filter in", v)
		}
	}
	return &ret, nil
}

type ClassData struct {
	Class     *TClassdecl    // the class header
	Typedef   *TTypedecl     // the typedef header
	Abstract  *TAbstractdecl // the abstract header
	Constants []*CField      // the constants to show
	Variables []*CField      // the variables to show
	Functions []*CField      // the functions to show
	Examples  []Example      // examples at class level, for the Typedef
}

func (cd *ClassData) AddField(fld *CField) {
	if fld.Public {
		if strings.HasPrefix(fld.XMLName.Local, "__") && strings.HasSuffix(fld.XMLName.Local, "__") {
			// it is a go2hx system generated field, ignore
			return
		}
		decl := fld.Declaration()
		switch decl {
		case "function":
			cd.Functions = append(cd.Functions, fld)
		case "var":
			cd.Variables = append(cd.Variables, fld)
		case "final":
			cd.Constants = append(cd.Constants, fld)
		default:
			panic("unknonwn declaration: " + decl)
		}
	}
}

type DirData struct {
	Module      string      // the module in this directory
	Doc         string      // package level documentation
	TestModule  string      // the module to run to test the package
	Examples    []Example   // this to provide an index of Examples
	ModuleLevel ClassData   // module of the variables and functions below
	Classes     []ClassData // the classes for this directory
	Typedefs    []ClassData // the typedefs for this directory
}

type Dirs map[string]DirData

func (a Dirs) AddFile(fp, module string) string {
	d, _ := filepath.Split(fp)
	dir := filepath.ToSlash(d)
	if _, ok := a[dir]; !ok {
		a[dir] = DirData{
			Module:  module,
			Classes: make([]ClassData, 0),
		}
	}
	return dir
}

func (a Dirs) DirList() []string {
	dirs := []string{}
	for name := range a {
		dirs = append(dirs, name)
	}
	sort.Strings(dirs)
	return dirs
}

func (tt *TypeTree) FindDirs() (Dirs, error) {
	an := make(Dirs)

	for _, a := range tt.Abstracts {
		dir := an.AddFile(a.File, a.Module)
		_ = dir // TODO build abstracts too, as used in stdgo (if not go2hx output)
	}

	for i, a := range tt.Classes {

		tt.Classes[i].SortFields() // sort the field names

		dir := an.AddFile(a.File, a.Module)
		dd := an[dir]
		if strings.HasSuffix(a.Path, "_Fields_") {
			// Module level class
			dd.ModuleLevel.Class = &tt.Classes[i]
			for j, f := range tt.Classes[i].Fields {
				if f.XMLName.Local == "__go2hxdoc__package" {
					dd.Doc = f.Doc // package level documentation
				}
				dd.ModuleLevel.AddField(&tt.Classes[i].Fields[j])
			}
		} else {
			// Ordinary class
			if !tt.Classes[i].Private && !strings.HasSuffix(tt.Classes[i].Path, "_asInterface") {
				cd := ClassData{
					Class: &tt.Classes[i],
				}
				for j := range tt.Classes[i].Fields {
					cd.AddField(&tt.Classes[i].Fields[j])
				}

				using := tt.Classes[i].MetaInfo.Using()
				if using != "" {
					if extn := tt.FindClass(tt.Classes[i].File, using); extn == nil {
						fmt.Printf("Warning - @:using class " + using + " not found")
					} else {
						for ex := range extn.Fields {
							extn.Fields[ex].TypeIs1stParam = true // signal to strip first parameter from call sig
							cd.AddField(&extn.Fields[ex])
						}
					}
				}
				dd.Classes = append(dd.Classes, cd)

				sort.Slice(dd.Classes, func(i, j int) bool {
					return dd.Classes[i].Class.Path < dd.Classes[j].Class.Path
				})
			}
		}
		an[dir] = dd
	}

	for i, td := range tt.Typedefs {
		if !td.Private {
			dir := an.AddFile(td.File, td.Module)
			dd := an[dir]
			cd := ClassData{
				Typedef: &tt.Typedefs[i],
			}
			using := tt.Typedefs[i].MetaInfo.Using()
			if using != "" {
				if extn := tt.FindClass(tt.Typedefs[i].File, using); extn == nil {
					fmt.Printf("Warning - @:using class " + using + " not found")
				} else {
					for ex := range extn.Fields {
						extn.Fields[ex].TypeIs1stParam = true // signal to strip first parameter from call sig
						cd.AddField(&extn.Fields[ex])
					}
				}
			}
			dd.Typedefs = append(dd.Typedefs, cd)

			sort.Slice(dd.Typedefs, func(i, j int) bool {
				return dd.Typedefs[i].Typedef.Path < dd.Typedefs[j].Typedef.Path
			})
			an[dir] = dd
		}
	}

	for _, a := range tt.Enums {
		an.AddFile(a.File, a.Module)
	}

	// find test module & directory, if it exists
	tm := "" // test module
	td := "" // test directory
	for name, nameData := range an {
		if strings.Contains(name, "_test") {
			tm = nameData.Module
			td = name
			break
		}
	}

	// write the module back in the header of the code directory
	cd := "" // the code directory
	if tm != "" {
		for name, nameData := range an {
			if !strings.Contains(name, "_test") {
				nameData.TestModule = tm
				an[name] = nameData
				cd = name
			}
		}
	}

	// find the example code and add it to the
	if td != "" {
		testCode := an[td]
		codeDir := an[cd]
		for _, testFun := range testCode.ModuleLevel.Functions {
			tstNam := testFun.XMLName.Local
			if strings.HasPrefix(tstNam, "example") {
				testForRunes := []rune(strings.Split(strings.TrimPrefix(tstNam, "example"), "_")[0]) // multiple functions can have _explanation

				// typedef examples
				for k, v := range codeDir.Typedefs {
					_ = k
					if v.Typedef.Name() == string(testForRunes) {
						//fmt.Println("DEBUG found typedef example ", v.Typedef.Name(), string(testForRunes))
						ex := Example{
							Name: testFun.XMLName.Local,
							File: testFun.File,
							Line: testFun.Line,
						}
						codeDir.Typedefs[k].Examples = append(codeDir.Typedefs[k].Examples, ex)
						codeDir.Examples = append(codeDir.Examples, ex)
						sort.Slice(codeDir.Examples, func(i, j int) bool {
							return codeDir.Examples[i].Name < codeDir.Examples[j].Name
						})
						an[cd] = codeDir // write it back
					}
				}

				// module level function examples
				if len(testForRunes) > 0 {
					testForRunes[0] = unicode.ToLower(testForRunes[0])
				}
				testForFn := string(testForRunes)
				for k, v := range codeDir.ModuleLevel.Functions {
					//fmt.Println("Testing Example", v.XMLName.Local, testForFn)
					if v.XMLName.Local == testForFn {
						//fmt.Println("found")
						ex := Example{
							Name: testFun.XMLName.Local,
							File: testFun.File,
							Line: testFun.Line,
						}
						codeDir.ModuleLevel.Functions[k].Examples = append(codeDir.ModuleLevel.Functions[k].Examples, ex)
						codeDir.Examples = append(codeDir.Examples, ex)
						sort.Slice(codeDir.Examples, func(i, j int) bool {
							return codeDir.Examples[i].Name < codeDir.Examples[j].Name
						})
						an[cd] = codeDir // write it back
					}
				}
			}
		}
	}

	return an, nil
}

func XMLread(filename string) (*TypeTree, error) {
	rawXml, err := os.ReadFile(filename)
	if err != nil {
		return nil, err
	}
	var r TypeTree
	if err := xml.Unmarshal(rawXml, &r); err != nil {
		return nil, err
	}

	if len(r.Others) > 0 {
		return nil, fmt.Errorf("XMLread faild to process the following top level items %v", r.Others)
	}

	return &r, nil
}
