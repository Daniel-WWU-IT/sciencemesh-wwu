/**************************************************************************************************
 * File:   webapi
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package exporters

import (
	"fmt"
	"net/http"

	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/env/config"
	"github.com/sciencemesh/mentix/exporters/webapi"
)

type WebAPIExporter struct {
	BaseExporter

	serverPort uint
	server     *http.Server
	serverMux  *http.ServeMux
}

func (exporter *WebAPIExporter) Activate(environ *env.Environment) error {
	if err := exporter.BaseExporter.Activate(environ); err != nil {
		return err
	}

	// Check and store WebAPI specific settings
	exporter.serverPort = environ.Config().Exporters.WebAPI.Port
	if exporter.serverPort == 0 {
		return fmt.Errorf("no valid server port configured")
	}

	// Create the HTTP server
	if err := exporter.createHTTPServer(); err != nil {
		return fmt.Errorf("Unable to create HTTP server: %v", err)
	}

	exporter.printInfo()
	return nil
}

func (exporter *WebAPIExporter) createHTTPServer() error {
	// Create a server mux to handle request endpoints
	exporter.serverMux = http.NewServeMux()
	exporter.serverMux.Handle("/", http.HandlerFunc(exporter.serveQueryEndpoint)) // The root path defaults to the query endpoint
	exporter.serverMux.Handle("/query", http.HandlerFunc(exporter.serveQueryEndpoint))

	// Create an HTTP server instance
	exporter.server = &http.Server{
		Addr:    fmt.Sprintf(":%v", exporter.serverPort),
		Handler: exporter.serverMux,
	}

	return nil
}

func (exporter *WebAPIExporter) Start() error {
	// Launch asynchronous HTTP server
	go exporter.server.ListenAndServe()

	return nil
}

func (exporter *WebAPIExporter) Stop() {
	exporter.server.Close()
}

func (exporter *WebAPIExporter) serveQueryEndpoint(resp http.ResponseWriter, req *http.Request) {
	exporter.printRequestInfo(req)

	// Data is read, so acquire a read lock
	exporter.locker.RLock()
	defer exporter.locker.RUnlock()

	data, err := webapi.HandleQuery(exporter.meshData, req.URL.Query())
	if err == nil {
		resp.Write(data)
	} else {
		resp.Write([]byte(fmt.Sprintf("Error while serving API request: %v", err)))
		exporter.environment.Log().Errorf(config.ExporterID_WebAPI, "Error while serving API request: %v", err)
	}
}

func (exporter *WebAPIExporter) GetName() string {
	return "WebAPI"
}

func (exporter *WebAPIExporter) printRequestInfo(req *http.Request) {
	exporter.environment.Log().Debugf(config.ExporterID_WebAPI, "%v -> %v?%v", req.RemoteAddr, req.URL.Path, req.URL.RawQuery)
}

func (exporter *WebAPIExporter) printInfo() {
	exporter.environment.Log().Infof(config.ExporterID_WebAPI, "Port: %v", exporter.serverPort)
}

func init() {
	registerExporter(config.ExporterID_WebAPI, &WebAPIExporter{})
}
