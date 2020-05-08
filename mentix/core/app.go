/**************************************************************************************************
 * File:   app.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import (
	"fmt"

	"github.com/sciencemesh/mentix/engine"
	"github.com/sciencemesh/mentix/env"
)

type MentixApp struct {
	environment *env.Environment

	engine *engine.Engine
}

var (
	appInstance *MentixApp
)

func (app *MentixApp) initialize(environ *env.Environment) error {
	if environ == nil {
		return fmt.Errorf("no environment provided")
	}
	app.environment = environ

	// We are ready to start
	app.logSessionStart()

	// Initialize the engine
	engine, err := engine.NewEngine(environ)
	if err != nil {
		return fmt.Errorf("unable to create engine: %v", err)
	}
	app.engine = engine

	return nil
}

func (app *MentixApp) destroy() {
	app.logSessionEnd()
}

func (app *MentixApp) Run() error {
	// Shut down the app automatically after Run() has finished
	defer app.destroy()

	// The engine will do the actual work
	return app.engine.Run()
}

func (app *MentixApp) logSessionStart() {
	app.environment.Log().Info("Mentix session started:")
	app.environment.Log().Infof("\t<b>Version:</> %v", GetVersionStringWithBuild())
	app.environment.Log().Infof("\t<b>Configuration:</> %v", app.environment.GetConfigFilename())

	if app.environment.Config().Core.Logging.Enabled {
		app.environment.Log().Infof("\t<b>log file:</> %v", app.environment.GetLogFilename())
	}
}

func (app *MentixApp) logSessionEnd() {
	app.environment.Log().Info("Mentix session ended")
}

func NewMentixApp(environ *env.Environment) (*MentixApp, error) {
	// Ensure that only one Mentix app exists
	if appInstance != nil {
		return appInstance, nil
	} else {
		appInstance = new(MentixApp)
		if err := appInstance.initialize(environ); err != nil {
			return nil, fmt.Errorf("unable to initialize the Mentix app: %v", err)
		}
		return appInstance, nil
	}
}
