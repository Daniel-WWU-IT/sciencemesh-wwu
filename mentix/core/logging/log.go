/**************************************************************************************************
 * File:   log.go
 * Date:   2020-05-06
 * Author: Daniel Müller (daniel.mueller@uni-muenster.de)
 *************************************************************************************************/

package logging

import (
	"fmt"
	"os"
	"strings"
	"time"
)

const (
	LogLevelDebug = iota
	LogLevelInfo
	LogLevelWarning
	LogLevelError
)

const (
	tagBegin = '<'
	tagEnd   = '>'
	tagPop   = "/"
)

type TextLogger struct {
	logToFile bool
	logLevel  int
	logFile   *os.File

	attributeTags map[string]Attribute
}

func (logger *TextLogger) initialize(logFilename string) error {
	logger.fillAttributeTags()

	// Open a file for logging; if it already exists, new entries will be appended
	if err := logger.openLogFile(logFilename); err != nil {
		return fmt.Errorf("error while opening the log file: %v", err)
	}

	// Ensure a new line at the end of the log
	stats, err := os.Stat(logFilename)
	if err == nil {
		if stats.Size() > 0 {
			logger.logFile.WriteString("\n")
		}
	}

	logger.logSessionInfo()
	return nil
}

func (logger *TextLogger) fillAttributeTags() {
	logger.attributeTags = make(map[string]Attribute)

	// Map tag names to color attributes
	logger.attributeTags["b"] = Bold
	logger.attributeTags["i"] = Italic
	logger.attributeTags["u"] = Underline
	logger.attributeTags["red"] = FgRed
	logger.attributeTags["green"] = FgGreen
	logger.attributeTags["yellow"] = FgYellow
	logger.attributeTags["blue"] = FgBlue
	logger.attributeTags["magenta"] = FgMagenta
	logger.attributeTags["cyan"] = FgCyan
}

func (logger *TextLogger) Close() {
	logger.closeLogFile()
}

func (logger *TextLogger) openLogFile(logFilename string) error {
	file, err := os.OpenFile(logFilename, os.O_CREATE|os.O_APPEND|os.O_WRONLY, os.ModePerm)
	if err != nil {
		return fmt.Errorf("unable to create log file '%v': %v", logFilename, err)
	}
	logger.logFile = file

	return nil
}

func (logger *TextLogger) closeLogFile() {
	if logger.logFile != nil {
		logger.logFile.Close()
	}
}

func (logger *TextLogger) logSessionInfo() {
	// Write a line denoting the start of the current session
	timestamp := time.Now()
	timestring := fmt.Sprintf("--- Session started at %d-%02d-%02d %d:%02d:%02d ---", timestamp.Year(), timestamp.Month(), timestamp.Day(), timestamp.Hour(), timestamp.Minute(), timestamp.Second())
	logger.logMessage(timestring)
}

func (logger *TextLogger) Info(msg string) {
	logger.log(msg, LogLevelInfo)
}

func (logger *TextLogger) Infof(format string, args ...interface{}) {
	logger.log(fmt.Sprintf(format, args...), LogLevelInfo)
}

func (logger *TextLogger) Warning(msg string) {
	logger.log(msg, LogLevelWarning)
}

func (logger *TextLogger) Warningf(format string, args ...interface{}) {
	logger.log(fmt.Sprintf(format, args...), LogLevelWarning)
}

func (logger *TextLogger) Error(msg string) {
	logger.log(msg, LogLevelError)
}

func (logger *TextLogger) Errorf(format string, args ...interface{}) {
	logger.log(fmt.Sprintf(format, args...), LogLevelError)
}

func (logger *TextLogger) Debug(msg string) {
	logger.log(msg, LogLevelDebug)
}

func (logger *TextLogger) Debugf(format string, args ...interface{}) {
	logger.log(fmt.Sprintf(format, args...), LogLevelDebug)
}

func (logger *TextLogger) log(msg string, logLevel int) {
	if logLevel >= logger.logLevel {
		timestamp := time.Now()
		timestring := fmt.Sprintf("%d-%02d-%02d %d:%02d:%02d", timestamp.Year(), timestamp.Month(), timestamp.Day(), timestamp.Hour(), timestamp.Minute(), timestamp.Second())
		logText := fmt.Sprintf("[%v] <b>%v:</> %v", timestring, logger.getFormattedLogLevelName(logLevel), msg)

		rawText := logger.printMessage(logText)
		logger.logMessage(rawText)
	}
}

func (logger *TextLogger) printMessage(msg string) (rawString string) {
	var attributeStack []string
	var inTag bool
	var curTag string
	var curText string

	printCurrentText := func() {
		if len(curText) > 0 {
			logger.printColorizedText(curText, attributeStack)
			curText = ""
		}
	}

	// Parse all <...> tags and print everything in between
	for _, c := range msg {
		if c == tagBegin && !inTag { // New tag started
			printCurrentText()
			inTag = true
			continue
		} else if c == tagEnd && inTag { // Current tag ended
			// Push/pop text attributes
			if curTag == tagPop && len(attributeStack) > 0 {
				attributeStack = attributeStack[:len(attributeStack)-1]
			} else {
				attributeStack = append(attributeStack, curTag)
			}

			inTag = false
			curTag = ""
			continue
		}

		if inTag { // Append current tag
			curTag += string(c)
		} else { // Append current text token
			curText += string(c)
			rawString += string(c)
		}
	}
	printCurrentText()
	fmt.Println("")

	return rawString
}

func (logger *TextLogger) printColorizedText(text string, attributes []string) {
	// Print colorized text using the 'color' package
	printer := NewColor(logger.getColorAttributes(attributes)...)
	printer.Print(text)
}

func (logger *TextLogger) logMessage(text string) {
	if logger.logToFile {
		logger.logFile.WriteString(text + "\n")
	}
}

func (logger *TextLogger) getColorAttributes(attributes []string) []Attribute {
	var colorAttributes []Attribute

	for _, attrs := range attributes {
		// Attributes can consist of multiple values, separated by commas
		for _, attr := range strings.Split(attrs, ",") {
			if value, ok := logger.attributeTags[strings.TrimSpace(attr)]; ok {
				colorAttributes = append(colorAttributes, value)
			}
		}
	}

	return colorAttributes
}

func (logger *TextLogger) getFormattedLogLevelName(logLevel int) string {
	switch logLevel {
	case LogLevelInfo:
		return "<green>INFO</>"

	case LogLevelWarning:
		return "<yellow>WARN</>"

	case LogLevelError:
		return "<red> ERR</>"

	case LogLevelDebug:
		return "<blue> DBG</>"

	default:
		return ""
	}
}

func NewTextLogger(logDir string, logToFile bool, logLevel int) (*TextLogger, error) {
	logger := &TextLogger{logToFile: logToFile, logLevel: logLevel}
	if err := logger.initialize(logDir); err != nil {
		return nil, fmt.Errorf("unable to initialize the logger: %v", err)
	}
	return logger, nil
}
