/**************************************************************************************************
 * File:   cli.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import "flag"

var (
	flag_configFile = flag.String("config", "", "specifies the Mentix configuration file to use")
)
