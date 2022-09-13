// extractfunc is a simplistic way to get Haxe function code from a file.
package extractfunc

import (
	"bytes"
	"os"

	"github.com/go2hx/go2hxdoc/rtti"
)

type FuncExtractor struct {
	fileContents map[string][][]byte
}

func (fe *FuncExtractor) GetExample(ex *rtti.Example) []byte {
	if fe.fileContents == nil {
		fe.fileContents = make(map[string][][]byte)
	}
	lines, found := fe.fileContents[ex.File]
	if !found {
		byts, err := os.ReadFile(ex.File)
		if err != nil {
			panic(err)
		}
		lines = bytes.Split(byts, []byte("\n"))
		fe.fileContents[ex.File] = lines
	}
	ret := []byte{}
	hadBody := false
	depth := 0
	for l := ex.Line - 1; !hadBody || depth > 0; l++ {
		ret = append(ret, lines[l]...)
		ret = append(ret, '\n')
		for _, byt := range lines[l] {
			switch byt {
			case byte('{'):
				hadBody = true
				depth++
			case byte('}'):
				depth--
			}
		}
	}
	return ret
}
