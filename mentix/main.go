/**************************************************************************************************
 * File:   main.go
 * Date:   2020-05-05
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package main

import (
	"log"

	"github.com/sciencemesh/mentix/core"
	"github.com/sciencemesh/mentix/env"
)

func main() {
	// Create the environment this application will run in
	environ, err := env.NewEnvironment()
	if err != nil {
		log.Fatalf("No environment could be created: %v", err)
	}
	defer environ.Close()

	// Create the actual application
	app, err := core.NewMentixApp(environ)
	if err != nil {
		log.Fatalf("Mentix app could not be created: %v", err)
	}

	// Just let the app run and do its job
	if err := app.Run(); err != nil {
		log.Fatalf("An error occurred while running Mentix: %v", err)
	}
}
