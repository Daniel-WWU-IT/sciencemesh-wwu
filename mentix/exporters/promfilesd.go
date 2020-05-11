/**************************************************************************************************
 * File:   promfilesd
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package exporters

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"os"
	"path"
	"path/filepath"

	"github.com/sciencemesh/mentix/env"
	"github.com/sciencemesh/mentix/env/config"
	"github.com/sciencemesh/mentix/exporters/prometheus"
	"github.com/sciencemesh/mentix/meshdata"
)

type PrometheusFileSDExporter struct {
	BaseExporter

	outputFilename string
}

func (exporter *PrometheusFileSDExporter) Activate(environ *env.Environment) error {
	if err := exporter.BaseExporter.Activate(environ); err != nil {
		return err
	}

	// Check and store Prometheus File SD specific settings
	exporter.outputFilename = environ.Config().Exporters.PrometheusFileSD.OutputFile
	if len(exporter.outputFilename) == 0 {
		return fmt.Errorf("no output filename configured")
	}

	// Create the output directory
	os.MkdirAll(filepath.Dir(exporter.outputFilename), os.ModePerm)

	exporter.printInfo()
	return nil
}

func (exporter *PrometheusFileSDExporter) UpdateMeshData(meshData *meshdata.MeshData) error {
	if err := exporter.BaseExporter.UpdateMeshData(meshData); err != nil {
		return err
	}

	return exporter.safePerform(exporter.meshDataUpdated)
}

func (exporter *PrometheusFileSDExporter) meshDataUpdated() error {
	scrapes := exporter.createScrapeConfigs()
	if err := exporter.exportScrapeConfig(scrapes); err != nil {
		return fmt.Errorf("unable to export mesh data: %v", err)
	}

	return nil
}

func (exporter *PrometheusFileSDExporter) createScrapeConfigs() []*prometheus.ScrapeConfig {
	var scrapes []*prometheus.ScrapeConfig
	var addScrape = func(site *meshdata.Site, host string, endpoint *meshdata.ServiceEndpoint) {
		if scrape := exporter.createScrapeConfig(site, host, endpoint); scrape != nil {
			scrapes = append(scrapes, scrape)
		}
	}

	// Create a scrape config for each service alongside any additional endpoints
	for _, site := range exporter.meshData.Sites {
		for _, service := range site.Services {
			if !service.IsMonitored {
				continue
			}

			// Add the "main" service to the scrapes
			addScrape(site, service.Host, &service.ServiceEndpoint)

			for _, endpoint := range service.AdditionalEndpoints {
				if endpoint.IsMonitored {
					addScrape(site, service.Host, endpoint)
				}
			}
		}
	}

	return scrapes
}

func (exporter *PrometheusFileSDExporter) createScrapeConfig(site *meshdata.Site, host string, endpoint *meshdata.ServiceEndpoint) *prometheus.ScrapeConfig {
	return &prometheus.ScrapeConfig{
		Targets: []string{path.Join(host, endpoint.Path)},
		Labels: map[string]string{
			"site":         site.Name,
			"service-type": endpoint.Type.Name,
		},
	}
}

func (exporter *PrometheusFileSDExporter) exportScrapeConfig(v interface{}) error {
	// Encode scrape config as JSON
	data, err := json.MarshalIndent(v, "", "\t")
	if err != nil {
		return fmt.Errorf("unable to marshal scrape config: %v", err)
	}

	// Write the data to disk
	if err := ioutil.WriteFile(exporter.outputFilename, data, os.ModePerm); err != nil {
		return fmt.Errorf("unable to write scrape config '%v': %v", exporter.outputFilename, err)
	}
	exporter.environment.Log().Infof(config.ExporterID_PrometheusFileSD, "Exported scrape config to '%v'", exporter.outputFilename)

	return nil
}

func (exporter *PrometheusFileSDExporter) GetName() string {
	return "Prometheus File SD"
}

func (exporter *PrometheusFileSDExporter) printInfo() {
	exporter.environment.Log().Infof("prm-fsd", "Output filename: %v", exporter.outputFilename)
}

func init() {
	registerExporter(config.ExporterID_PrometheusFileSD, &PrometheusFileSDExporter{})
}
