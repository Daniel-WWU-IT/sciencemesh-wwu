/**************************************************************************************************
 * File:   app.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import (
	"flag"
	"fmt"
	"log"
	"os"
	"path/filepath"
	"time"

	"github.com/sciencemesh/mentix/connectors"
	"github.com/sciencemesh/mentix/core/config"
	"github.com/sciencemesh/mentix/core/logging"
	"github.com/sciencemesh/mentix/engine"
)

type MentixApp struct {
	appDir string

	config *config.MentixConfig
	logger *logging.TextLogger

	engine *engine.MentixEngine
}

var (
	appInstance *MentixApp
)

func (app *MentixApp) initialize() error {
	// Parse any provided commandline flags
	flag.Parse()

	// Get the directory of Mentix
	dir, err := filepath.Abs(filepath.Dir(os.Args[0]))
	if err != nil {
		return fmt.Errorf("could not retrieve app directory: %v", err)
	}
	app.appDir = dir

	// Prepare the configuration
	app.config = config.NewMentixConfig(app.appDir)
	app.config.Settings.Engine.Connector = connectors.GOCDBConnectorID // Use the GOCDB connector by default
	if err := app.config.Load(app.getConfigFilename()); err != nil {
		return fmt.Errorf("unable to load the Mentix configuration: %v", err)
	}

	// Activate logging; this has to be done after loading the configuration, as the log directory is needed for this
	logger, err := logging.NewTextLogger(app.getLogFilename(), app.config.Settings.Core.Logging.Enabled, app.config.Settings.Core.Logging.Level)
	if err != nil {
		return fmt.Errorf("unable to create a text logger: %v", err)
	}
	app.logger = logger

	app.logSessionStart()

	// Finally, initialize the engine
	engine, err := engine.NewMentixEngine(app.config)
	if err != nil {
		return fmt.Errorf("unable to create the Mentix engine: %v", err)
	}
	app.engine = engine

	return nil
}

func (app *MentixApp) destroy() {
	app.logger.Close()

	app.logSessionEnd()
}

func (app *MentixApp) getConfigFilename() string {
	// If a configuration file was specified via commandline, use that one; otherwise, use the default one
	configFile := *CLI_ConfigFile
	if len(configFile) == 0 {
		configFile = config.FN_ConfigFile
	}

	// Relative filenames are treated to be relative to the Mentix app dir
	if !filepath.IsAbs(configFile) {
		configFile = app.config.SafeResolveFilename(configFile)
	}

	return configFile
}

func (app *MentixApp) getLogFilename() string {
	timestamp := time.Now()
	filename := fmt.Sprintf("mentix-%d-%02d-%02d.log", timestamp.Year(), timestamp.Month(), timestamp.Day())
	return app.config.SafeResolvePath(app.config.Settings.Core.Logging.Directory, filename)
}

func (app *MentixApp) Run() error {
	// Shut down the app automatically after Run() has finished
	defer app.destroy()

	// The engine will do the actual work
	return app.engine.Run()
}

func (app *MentixApp) logSessionStart() {
	app.logger.Info("Mentix session started:")
	app.logger.Infof("\t<b>Version:</> %v", GetVersionStringWithBuild())
	app.logger.Infof("\t<b>Configuration:</> %v", app.getConfigFilename())

	if app.config.Settings.Core.Logging.Enabled {
		app.logger.Infof("\t<b>Log file:</> %v", app.getLogFilename())
	}
}

func (app *MentixApp) logSessionEnd() {
	app.logger.Info("Mentix session ended")
}

func (app *MentixApp) Config() *config.MentixConfig {
	return app.config
}

func (app *MentixApp) Log() *logging.TextLogger {
	return app.logger
}

func (app *MentixApp) Engine() *engine.MentixEngine {
	return app.engine
}

func NewMentixApp() (*MentixApp, error) {
	// Ensure that only one Mentix app exists
	if appInstance != nil {
		return appInstance, nil
	} else {
		appInstance = new(MentixApp)
		if err := appInstance.initialize(); err != nil {
			return nil, fmt.Errorf("unable to initialize the Mentix app: %v", err)
		}
		return appInstance, nil
	}
}

func Mentix() *MentixApp {
	if appInstance == nil {
		// This should never happen
		log.Fatal("Accessed uninitialized Mentix app")
	}

	return appInstance
}
