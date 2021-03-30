package letter

import (
	"log"
	"strings"
	"testing"

	"github.com/topikettunen/ascii-art-gen/letter"
)

func TestReadLetters(t *testing.T) {
	letters := letter.ReadLetters()

	tests := []struct {
		letter   string
		expected string
	}{
		{
			`___  
 / _ \ 
/ /_\ \
|  _  |
| | | |
\_| |_/`,
			"a",
		},
		{
			`______
|___  /
   / / 
  / /  
./ /___
\_____/`,
			"z",
		},
	}

	for _, test := range tests {
		log.Println(strings.TrimSpace(letters[test.expected]))
		log.Println(test.letter)
		if strings.TrimSpace(letters[test.expected]) != test.letter {
			t.Errorf("bad letter")
		}
	}

}
