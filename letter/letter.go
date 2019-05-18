package letter

import (
	"bufio"
	"log"
	"os"
	"path/filepath"
	"strings"
)

const (
	alphabets = "abcdefghijklmnopqrstuvwxyz"
)

func ReadLetters() map[string]string {
	path, err := filepath.Abs("letter/letters.txt")
	if err != nil {
		log.Fatalf("failed representing fullpath : %s", err)
	}

	file, err := os.Open(path)
	if err != nil {
		log.Fatalf("failed opening file: %s", err)
	}

	scanner := bufio.NewScanner(file)
	scanner.Split(bufio.ScanLines)

	asciiArtLetters := make(map[string]string)
	var singleLetterArt strings.Builder

	emptyLineCounter := 0
	currentLetter := 0

	for scanner.Scan() {
		if len(scanner.Text()) == 0 {
			emptyLineCounter++
			if emptyLineCounter == 2 {
				emptyLineCounter = 0
				asciiArtLetters[string(alphabets[currentLetter])] = singleLetterArt.String()
				currentLetter++
				singleLetterArt.Reset()
				continue
			}
		} else {
			singleLetterArt.WriteString(scanner.Text())
			singleLetterArt.WriteRune('\n')
		}
	}

	file.Close()

	return asciiArtLetters
}

func SplitLetters(word string, letters map[string]string) [][]string {
	var splitLetters [][]string

	for _, e := range word {
		splitLetters = append(splitLetters, strings.Split(letters[string(e)], "\n"))
	}

	return splitLetters
}
