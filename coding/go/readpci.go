package main

import (
	"fmt"
        "os"
        "log"
	"io/ioutil"
	"path/filepath"
	"strings"
)

// InstanceFeature represents one instance of a complex features, e.g. a device.
type InstanceFeature struct {
	Attributes map[string]string `protobuf:"bytes,1,rep,name=attributes"`
}

var mandatoryDevAttrs = []string{"class", "vendor", "device", "subsystem_vendor", "subsystem_device"}
var optionalDevAttrs = []string{"sriov_totalvfs"}

func NewInstanceFeature() *InstanceFeature {
	return &InstanceFeature{Attributes: make(map[string]string)}
}

// Read a single PCI device attribute
// A PCI attribute in this context, maps to the corresponding sysfs file
func readSinglePciAttribute(devPath string, attrName string) (string, error) {
	data, err := ioutil.ReadFile(filepath.Join(devPath, attrName))
	if err != nil {
		fmt.Println("failed to read device attribute %s: %v", attrName, err)
		return "", nil
	}
	// Strip whitespace and '0x' prefix
	attrVal := strings.TrimSpace(strings.TrimPrefix(string(data), "0x"))

	if attrName == "class" && len(attrVal) > 4 {
		// Take four first characters, so that the programming
		// interface identifier gets stripped from the raw class code
		attrVal = attrVal[0:4]
	}
	return attrVal, nil
}

// Read information of one PCI device
func readPciDevInfo(devPath string) (InstanceFeature, error) {
	info := *(NewInstanceFeature())

	for _, attr := range mandatoryDevAttrs {
		attrVal, err := readSinglePciAttribute(devPath, attr)
		if err != nil {
			fmt.Println("failed to read device %s: %s", attr, err)
			return info, nil
		}
		info.Attributes[attr] = attrVal
	}
	for _, attr := range optionalDevAttrs {
		attrVal, err := readSinglePciAttribute(devPath, attr)
		if err == nil {
			info.Attributes[attr] = attrVal
		}
	}
	return info, nil
}

// detectPci detects available PCI devices and retrieves their device attributes.
// An error is returned if reading any of the mandatory attributes fails.
func detectPci() () {
    sysfsBasePath := "/sys/bus/pci/devices"

    devices, err := ioutil.ReadDir(sysfsBasePath)
    if err != nil {
        fmt.Println(err)
    }

    // Iterate over devices
    for _, device := range devices {
        info, err := readPciDevInfo(filepath.Join(sysfsBasePath, device.Name()))
        if err != nil {
            fmt.Println(err)
            continue
        }
	fmt.Println(info)
    }
}

func main() {
    fileName := "npd_debug.log"
    logFile,err  := os.Create(fileName)
    defer logFile.Close()
    if err != nil {
        log.Fatalln("open file error !")
    }
    debugLog := log.New(logFile,"[Debug]",log.Llongfile)
    debugLog.Println("A debug message here")
    debugLog.SetPrefix("[Info]")
    debugLog.Println("A Info Message here ")
    debugLog.Println("NPD Admission Webhook starting...")

    detectPci()
}
