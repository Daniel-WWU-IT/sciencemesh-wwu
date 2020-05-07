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
	attributeTags map[string]Attribute

	logToFileEnabled bool
	logLevel         int
	logFile          *os.File
}

type messageToken struct {
	text       string
	attributes []Attribute
}

func (logger *TextLogger) initialize(logFilename string) error {
	logger.fillAttributeTags()

	if logger.logToFileEnabled {
		// Open the log file; if it already exists, new entries will be appended
		if err := logger.openLogFile(logFilename); err != nil {
			return fmt.Errorf("error while opening log file '%v': %v", logFilename, err)
		}

		// Ensure a new line at the end of the log
		stats, err := os.Stat(logFilename)
		if err == nil {
			if stats.Size() > 0 {
				logger.logFile.WriteString("\n")
			}
		}

		logger.writeSessionStart()
	}

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

func (logger *TextLogger) writeSessionStart() {
	// Write a line denoting the start of the current session
	timestamp := time.Now()
	timestring := fmt.Sprintf("--- Session started at %d-%02d-%02d %d:%02d:%02d ---", timestamp.Year(), timestamp.Month(), timestamp.Day(), timestamp.Hour(), timestamp.Minute(), timestamp.Second())
	logger.writeMessage([]messageToken{{text: timestring}})
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
		// Format log entry
		timestamp := time.Now()
		timestring := fmt.Sprintf("%d-%02d-%02d %d:%02d:%02d", timestamp.Year(), timestamp.Month(), timestamp.Day(), timestamp.Hour(), timestamp.Minute(), timestamp.Second())
		logText := fmt.Sprintf("[%v] <b>%v:</> %v", timestring, logger.getFormattedLogLevelName(logLevel), msg)

		// Print and log the message
		tokens := logger.parseMessage(logText)
		logger.printMessage(tokens)
		if logger.logToFileEnabled {
			logger.writeMessage(tokens)
		}
	}
}

func (logger *TextLogger) parseMessage(msg string) []messageToken {
	var tokens []messageToken

	var attributeStack []string
	var curText string
	var inTag bool
	var addCurrentText = func() {
		if len(curText) > 0 {
			tokens = append(tokens, messageToken{text: curText, attributes: logger.getColorAttributes(attributeStack)})
			curText = ""
		}
	}

	// Parse all <...> tags and created attributed tokens
	for _, c := range msg {
		if c == tagBegin && !inTag { // New tag started
			addCurrentText()
			inTag = true
			continue
		} else if c == tagEnd && inTag { // Current tag ended
			// Push/pop text attributes
			if curText == tagPop && len(attributeStack) > 0 {
				attributeStack = attributeStack[:len(attributeStack)-1]
			} else {
				attributeStack = append(attributeStack, curText)
			}

			inTag = false
			curText = ""
			continue
		}

		curText += string(c)
	}
	addCurrentText()

	return tokens
}

func (logger *TextLogger) printMessage(tokens []messageToken) {
	for _, token := range tokens {
		// Print colorized text using the 'color' package
		printer := NewColor(token.attributes...)
		printer.Print(strings.ReplaceAll(token.text, "\t", "  "))
	}
	fmt.Println("")
}

func (logger *TextLogger) writeMessage(tokens []messageToken) {
	msg := ""
	for _, token := range tokens {
		msg += token.text
	}
	logger.logFile.WriteString(msg + "\n")
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
	logger := &TextLogger{logToFileEnabled: logToFile, logLevel: logLevel}
	if err := logger.initialize(logDir); err != nil {
		return nil, fmt.Errorf("unable to initialize the logger: %v", err)
	}
	return logger, nil
}
