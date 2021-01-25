package main

import (
	"context"
	"fmt"
	"log"
	"net/http"
	"os"
	"os/signal"
	"syscall"

	"github.com/topikettunen/ascii-art-gen/letter"
)

func printToConsole(word string, letters map[string]string) {
	splitLetters := letter.SplitLetters(word, letters)

	for i := range splitLetters[0] {
		for _, e := range splitLetters {
			fmt.Printf(e[i])
		}
		fmt.Printf("\n")
	}
}

func serveArt(letters map[string]string) {
	log.Println("Starting ascii-art-gen...")

	http.HandleFunc("/", func(w http.ResponseWriter, r *http.Request) {
		splitLetters := letter.SplitLetters(r.URL.Query().Get("w"), letters)
		for i := range splitLetters[0] {
			for _, e := range splitLetters {
				fmt.Fprintf(w, (e[i]))
			}
			fmt.Fprintf(w, "\n")
		}
	})

	s := http.Server{Addr: ":8080"}
	go func() {
		log.Fatal(s.ListenAndServe())
	}()

	signalChan := make(chan os.Signal, 1)
	signal.Notify(signalChan, syscall.SIGINT, syscall.SIGTERM)
	<-signalChan

	log.Println("Shutdown signal received, exiting...")

	s.Shutdown(context.Background())
}

func main() {
	args := os.Args[1:]

	letters := letter.ReadLetters()

	if args[0] == "--serve" {
		serveArt(letters)
	} else {
		printToConsole(args[0], letters)
	}
}
