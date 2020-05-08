/**************************************************************************************************
 * File:   site.go
 * Date:   2020-05-07
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package meshdata

type Site struct {
	Name         string
	FullName     string
	Organization string
	Domain       string
	Homepage     string
	Email        string
	Description  string

	Services   []*Service
	Properties map[string]string
}
