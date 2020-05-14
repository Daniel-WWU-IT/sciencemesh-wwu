/**************************************************************************************************
 * File:   types.go
 * Date:   2020-05-11
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package prometheus

type ScrapeConfig struct {
	Targets []string          `json:"targets"`
	Labels  map[string]string `json:"labels"`
}
