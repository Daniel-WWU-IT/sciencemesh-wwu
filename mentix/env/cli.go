/**************************************************************************************************
 * File:   cli.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package env

import "flag"

var (
	CLI_ConfigFile = flag.String("config", "", "specifies the Mentix configuration file to use")
)
