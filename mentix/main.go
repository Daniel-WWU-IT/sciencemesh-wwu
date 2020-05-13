/**************************************************************************************************
 * File:   main.go
 * Date:   2020-05-05
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package main

import (
	"log"
	"os"

	"github.com/sciencemesh/mentix/core"
	"github.com/sciencemesh/mentix/env"
)

const (
	ExitCodeSuccess = iota
	ExitCodeErrAppCreation
	ExitCodeErrAppRun
)

func main() {
	// Create the environment this application will run in
	environ, err := env.NewEnvironment()
	if err != nil {
		// Can't log this error, as the log doesn't exist yet
		log.Fatalf("No environment could be created: %v", err)
	}
	defer environ.Close()

	// Create the actual application
	app, err := core.NewMentixApp(environ)
	if err != nil {
		environ.Log().Errorf("", "Mentix app could not be created: %v", err)
		os.Exit(ExitCodeErrAppCreation)
	}

	// Just let the app run and do its job
	if err := app.Run(); err != nil {
		environ.Log().Errorf("", "An error occurred while running Mentix: %v", err)
		os.Exit(ExitCodeErrAppRun)
	}
}
