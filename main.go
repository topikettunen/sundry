package main

import (
	"fmt"
	"os"
	"strings"

	"github.com/topikettunen/ascii-art-gen/letter"
)

func main() {
	args := os.Args[1:]

	letters := letter.ReadLetters()

	var splitLetters [][]string

	for _, word := range args {
		for _, e := range word {
			splitLetters = append(splitLetters, strings.Split(letters[string(e)], "\n"))
		}
	}

	for i := range splitLetters[0] {
		for _, e := range splitLetters {
			fmt.Printf(e[i])
		}
		fmt.Printf("\n")
	}
}
