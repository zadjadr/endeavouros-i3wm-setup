package main

import (
	"flag"
	"fmt"
	"os"
	"os/exec"
	"strconv"
	"strings"
)

func main() {
	brightnessAdjustment := parseFlags()

	maxBrightness := getBrightness("max")
	currentBrightness := getBrightness("get")
	operation := extractOperation(brightnessAdjustment)

	currentBrightnessPercent := calculateBrightnessPercent(currentBrightness, maxBrightness)
	adjustment, err := strconv.ParseFloat(extractNumber(brightnessAdjustment), 32)
	if err != nil {
		fmt.Printf("Invalid brightness adjustment value: %v\n", err)
		os.Exit(1)
	}
	increment := calculateIncrement(currentBrightnessPercent, maxBrightness, operation)

	if shouldUseMinIncrement(currentBrightnessPercent, brightnessAdjustment, operation) {
		adjustBrightnessWithMinIncrement(currentBrightnessPercent, currentBrightness, increment, operation, adjustment)
	} else {
		setBrightness(brightnessAdjustment)
	}

	finalBrightnessPercent := calculateBrightnessPercent(getBrightness("get"), maxBrightness)
	notifyBrightness(finalBrightnessPercent)
}

// parseFlags handles the command-line arguments and returns the brightness adjustment value.
func parseFlags() string {
	brightnessFlag := flag.String("brightness", "", "Brightness adjustment (e.g., +10%, -10%, 50%)")
	flag.Parse()

	if *brightnessFlag == "" {
		fmt.Println("Usage: brightness -brightness <value>")
		os.Exit(1)
	}

	return *brightnessFlag
}

// getBrightness retrieves the brightness value as a float32 based on the command (max or current).
func getBrightness(command string) float32 {
	output, err := exec.Command("brightnessctl", command).Output()
	if err != nil {
		fmt.Printf("Error executing brightnessctl: %v\n", err)
		os.Exit(1)
	}

	value, err := strconv.ParseFloat(strings.TrimSpace(string(output)), 32)
	if err != nil {
		fmt.Printf("Error converting brightness value: %v\n", err)
		os.Exit(1)
	}

	return float32(value)
}

// calculateBrightnessPercent computes the current brightness percentage.
func calculateBrightnessPercent(currentValue, maxValue float32) float32 {
	return (currentValue / maxValue) * 100
}

// shouldUseMinIncrement determines if the adjustment should use a minimum increment based on the current brightness percentage.
func shouldUseMinIncrement(currentBrightnessPercent float32, adjustment string, operation string) bool {
	return (operation == "-" && currentBrightnessPercent <= 5.0) || (operation == "+" && currentBrightnessPercent < 5.0)
}

// calculateIncrement returns the increment value based on the current brightness percentage.
func calculateIncrement(currentBrightnessPercent, maxBrightness float32, operation string) int {
	if currentBrightnessPercent <= 1.0 && operation == "-" {
		return int(maxBrightness / 1000)
	}
	if currentBrightnessPercent < 1.0 {
		return int(maxBrightness / 1000)
	}
	return int(maxBrightness / 100)
}

// setBrightness sets the brightness to the specified value.
func setBrightness(value string) {
	err := exec.Command("brightnessctl", "set", value).Run()
	if err != nil {
		fmt.Printf("Error setting brightness: %v\n", err)
		os.Exit(1)
	}
}

// notifyBrightness sends a notification with the current brightness percentage.
func notifyBrightness(percent float32) {
	iconPath := fmt.Sprintf("%s/.config/dunst/icons/brightness.svg", os.Getenv("HOME"))
	cmd := exec.Command("notify-send", fmt.Sprintf("%.1f%%", percent), "-t", "500", "--icon", iconPath)
	cmd.Run()
}

// extractOperation extracts the operation (+ or -) from the brightness adjustment string.
func extractOperation(adjustment string) string {
	return strings.Trim(adjustment, "0123456789.%")
}

// extractNumber extracts the numeric value from the brightness adjustment string.
func extractNumber(adjustment string) string {
	return strings.Trim(adjustment, ".%+-")
}

// adjustBrightnessWithMinIncrement handles the brightness adjustment when a minimum increment is required.
func adjustBrightnessWithMinIncrement(currentBrightnessPercent, currentBrightness float32, increment int, operation string, adjustment float64) {
	switch operation {
	case "-":
		if currentBrightnessPercent == 0.1 {
			notifyBrightness(0.1)
			os.Exit(0)
		}
		if float32(adjustment) >= currentBrightnessPercent || increment >= int(currentBrightness) {
			newValue := currentBrightness - float32(increment)
			if newValue <= 0 {
				setBrightness("0.1%")
			} else {
				setBrightness(fmt.Sprintf("%.0f", newValue))
			}
		}
	case "+":
		if currentBrightnessPercent == 100 {
			notifyBrightness(100)
			os.Exit(0)
		}
		setBrightness(fmt.Sprintf("%.0f", currentBrightness+float32(increment)))
	}
}
