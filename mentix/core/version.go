/**************************************************************************************************
 * File:   version.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package core

import "fmt"

const (
	VersionMajor    = 0
	VersionMinor    = 1
	VersionRevision = 0
)

func GetVersionString() string {
	return fmt.Sprintf("%v.%v.%v", VersionMajor, VersionMinor, VersionRevision)
}
