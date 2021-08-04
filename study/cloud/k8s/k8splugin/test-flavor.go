package main

import (
	"fmt"
    "encoding/json"
	"strings"
	"github.com/satori/go.uuid"
)

type hpaPlacementPlugin struct {
}

type HpaValue struct {
    Value           string      `json:"value"`
    Unit            string      `json:"unit"`
}

type HpaAttr struct {
    HpaKey          string      `json:"hpa-attribute-key"`
    HpaValue        HpaValue    `json:"hpa-attribute-value"`
}

type HpaCap struct {
    HpaCapabilityId string      `json:"hpa-capability-id"`
    HpaFeature      string      `json:"hpa-feature"`
    Architecture    string      `json:"archtecture"`
    HpaVersion      string      `json:"hpa-version"`
    HpaAttr         []HpaAttr   `json:"hpa-feature-attributes"`
}

type HpaCaps struct {
    HpaCap          []HpaCap    `json:"hpa-capability"`
}

type FlavorInfo struct {
    Id              string      `json:"flavor-id"`
    Name            string      `json:"flavor-name"`
    Vcpus           string      `json:"flavor-vcpus"`
    Ram             string      `json:"flavor-ram"`
    Disk            string      `json:"flavor-disk"`
    Swap            string      `json:"flavor-swap"`
    Ephemeral       string      `json:"flavor-ephemeral"`
    IsPublic        string      `json:"flavor-is-public"`
    FlvDisabled     string      `json:"flavor-disabled"`
    HpaCaps         HpaCaps     `json:"hpa-capabilities"`
}

func DiscoverFlavor(features map[string]string, vimid string) (FlavorInfo, error) {
    hpaCapArr := []HpaCap{}
    hpaCap := HpaCap{}
    hpaAttr := HpaAttr{}
    hpaAttrArr := []HpaAttr{}
    hpaValue := HpaValue{}

	// For hpa capablilties
	// For sriov-nic
	for k, v := range features {
			if strings.Index(k, "network-sriov.capable") >= 1 {
                hpaValue = HpaValue{Value: v, Unit: ""}
                hpaAttr  = HpaAttr{HpaKey: "networkSriovCapable", HpaValue: hpaValue}
                hpaAttrArr = append(hpaAttrArr, hpaAttr)
			}
			if strings.Index(k, "network-sriov.configured") >=1 {
                hpaValue = HpaValue{Value: v, Unit: ""}
                hpaAttr  = HpaAttr{HpaKey: "networkSriovConfigured", HpaValue: hpaValue}
                hpaAttrArr = append(hpaAttrArr, hpaAttr)
			}
	}
    uid, err := uuid.NewV4()
    fmt.Println(err)
    hpaCap = HpaCap {
        HpaCapabilityId: uid.String(),
        HpaFeature: "sriovNICNetwork",
        Architecture: "intel",
        HpaVersion: "v1",
        HpaAttr: hpaAttrArr,
    }

    hpaCapArr = append(hpaCapArr, hpaCap)

    flavorInfo := FlavorInfo {
        Id: features["id"],
        Name: features["name"],
        Vcpus: features["vcpus"],
        Ram: features["ram"],
        Disk: features["disk"],
        Swap: features["swap"],
        Ephemeral: features["OS-FLV-EXT-DATA:ephemeral"],
        IsPublic: features["os-flavor-access:is_public"],
        FlvDisabled: features["OS-FLV-DISABLED:disabled"],
        HpaCaps: HpaCaps{
            HpaCap: hpaCapArr,
        },
    }

    flavorInfoByte, err := json.Marshal(flavorInfo)
    fmt.Println(string(flavorInfoByte))
    fmt.Println(err)

	return flavorInfo, nil
}

func (p hpaPlacementPlugin) GetFeaturesPerNode(clusterName string) (map[string]string, error) {
	var features = make(map[string]string)

	features["id"] = "1234"
	features["name"] = "test"
	features["vcpus"] = "1"
	features["ram"] = "512"
	features["disk"] = "1"
	features["swap"] = ""
	features["OS-FLV-EXT-DATA:ephemeral"] = "0"
	features["os-flavor-access:is_public"] = "True"
	features["OS-FLV-DISABLED:disabled"] = "False"
	features["feature.node.kubernetes.io/network-sriov.capable"] = "True"
	features["feature.node.kubernetes.io/network-sriov.configured"] = "True"

	return features, nil
}

func main() {
	p := hpaPlacementPlugin{}
	features, err := p.GetFeaturesPerNode("yui")
	if err != nil {
		fmt.Println("Ger feature fail!")
	}
	fmt.Println(features)

	flavor_info, err := DiscoverFlavor(features, "yui_hhb")
	if err != nil {
		fmt.Println("discover_flavor with error!")
	}
	fmt.Println(flavor_info)

}
