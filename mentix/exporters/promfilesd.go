/**************************************************************************************************
 * File:   promfilesd
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package exporters

import "github.com/sciencemesh/mentix/env/config"

type PrometheusFileSDExporter struct {
	BaseExporter
}

func (exporter *PrometheusFileSDExporter) GetName() string {
	return "Prometheus File SD"
}

func init() {
	registerExporter(config.ExporterID_PrometheusFileSD, &PrometheusFileSDExporter{})
}
