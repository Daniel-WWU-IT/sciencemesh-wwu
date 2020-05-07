/**************************************************************************************************
 * File:   main.go
 * Date:   2020-05-05
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package main

import (
	"log"

	"github.com/sciencemesh/mentix/core"
)

func main() {
	app, err := core.NewMentixApp()
	if err != nil {
		log.Fatalf("Mentix could not be started: %v", err)
	}

	// Just let the app run...
	if err := app.Run(); err != nil {
		log.Fatalf("An error occurred while running Mentix: %v", err)
	}
}
