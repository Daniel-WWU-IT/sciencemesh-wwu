/**************************************************************************************************
 * File:   logger.go
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
	LevelDebug = iota
	LevelInfo
	LevelWarning
	LevelError
)

const (
	tagBegin = '<'
	tagEnd   = '>'
	tagPop   = "/"
)

type Logger struct {
	attributeTags map[string]Attribute

	logToFileEnabled bool
	logLevel         int
	logFile          *os.File
}

type messageToken struct {
	text       string
	attributes []Attribute
}

func (logger *Logger) initialize(logFilename string) error {
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

func (logger *Logger) fillAttributeTags() {
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

func (logger *Logger) Close() {
	logger.closeLogFile()
}

func (logger *Logger) openLogFile(logFilename string) error {
	file, err := os.OpenFile(logFilename, os.O_CREATE|os.O_APPEND|os.O_WRONLY, os.ModePerm)
	if err != nil {
		return fmt.Errorf("unable to create log file '%v': %v", logFilename, err)
	}
	logger.logFile = file

	return nil
}

func (logger *Logger) closeLogFile() {
	if logger.logFile != nil {
		logger.logFile.Close()
	}
}

func (logger *Logger) writeSessionStart() {
	// Write a line denoting the start of the current session
	timestamp := time.Now()
	timestring := fmt.Sprintf("--- Session started at %d-%02d-%02d %d:%02d:%02d ---", timestamp.Year(), timestamp.Month(), timestamp.Day(), timestamp.Hour(), timestamp.Minute(), timestamp.Second())
	logger.logToFile([]messageToken{{text: timestring}})
}

func (logger *Logger) Info(scope string, msg string) {
	logger.log(scope, msg, LevelInfo)
}

func (logger *Logger) Infof(scope string, format string, args ...interface{}) {
	logger.log(scope, fmt.Sprintf(format, args...), LevelInfo)
}

func (logger *Logger) Warning(scope string, msg string) {
	logger.log(scope, msg, LevelWarning)
}

func (logger *Logger) Warningf(scope string, format string, args ...interface{}) {
	logger.log(scope, fmt.Sprintf(format, args...), LevelWarning)
}

func (logger *Logger) Error(scope string, msg string) {
	logger.log(scope, msg, LevelError)
}

func (logger *Logger) Errorf(scope string, format string, args ...interface{}) {
	logger.log(scope, fmt.Sprintf(format, args...), LevelError)
}

func (logger *Logger) Debug(scope string, msg string) {
	logger.log(scope, msg, LevelDebug)
}

func (logger *Logger) Debugf(scope string, format string, args ...interface{}) {
	logger.log(scope, fmt.Sprintf(format, args...), LevelDebug)
}

func (logger *Logger) log(scope string, msg string, logLevel int) {
	if logLevel >= logger.logLevel {
		// Format log entry
		timestamp := time.Now()
		timestring := fmt.Sprintf("%d:%02d:%02d", timestamp.Hour(), timestamp.Minute(), timestamp.Second())

		var logText string
		if len(scope) > 0 {
			logText = fmt.Sprintf("%v %v ▶ <b>%v</> %v", timestring, scope, logger.getFormattedLogLevelName(logLevel), msg)
		} else {
			logText = fmt.Sprintf("%v ▶ <b>%v</> %v", timestring, logger.getFormattedLogLevelName(logLevel), msg)
		}

		// Print and log the message
		tokens := logger.parseMessage(logText)
		logger.logToOutput(tokens)
		if logger.logToFileEnabled {
			logger.logToFile(tokens)
		}
	}
}

func (logger *Logger) parseMessage(msg string) []messageToken {
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

func (logger *Logger) logToOutput(tokens []messageToken) {
	for _, token := range tokens {
		// Print colorized text using the 'color' package
		printer := NewColor(token.attributes...)
		printer.Print(strings.ReplaceAll(token.text, "\t", "  "))
	}
	fmt.Println("")
}

func (logger *Logger) logToFile(tokens []messageToken) {
	msg := ""
	for _, token := range tokens {
		msg += token.text
	}
	logger.logFile.WriteString(msg + "\n")
}

func (logger *Logger) getColorAttributes(attributes []string) []Attribute {
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

func (logger *Logger) getFormattedLogLevelName(logLevel int) string {
	switch logLevel {
	case LevelInfo:
		return "<green>INF</>"

	case LevelWarning:
		return "<yellow>WRN</>"

	case LevelError:
		return "<red>ERR</>"

	case LevelDebug:
		return "<blue>DBG</>"

	default:
		return ""
	}
}

func NewLogger(logDir string, logToFile bool, logLevel int) (*Logger, error) {
	logger := &Logger{logToFileEnabled: logToFile, logLevel: logLevel}
	if err := logger.initialize(logDir); err != nil {
		return nil, fmt.Errorf("unable to initialize logger: %v", err)
	}
	return logger, nil
}
