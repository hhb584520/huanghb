curl -k -v -X PUT https://pdp:8081/pdp/api/updatePolicy \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -H 'ClientAuth: cHl0aG9uOnRlc3Q=' \
  -H 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' \
  -H 'Environment: TEST' \
  -d '{
        "policyName":"oofCasablanca.Optimization_vCPE_Infrastructure_GW_demo_app",
        "policyConfigType": "Optimization",
        "onapName": "SampleDemo",
        "policyScope": "oofCasablanca",
        "configBody":"{
          \"service\":\"hpaPolicy\",
          \"policyName\":\"oofCasablanca.Optimization_vCPE_Infrastructure_GW_demo_app\",
          \"description\":\"OOF Policy\",
          \"templateVersion\":\"OpenSource.version.1\",
          \"version\":\"1.0\",
          \"priority\":\"3\",
          \"riskType\":\"Test\",
          \"riskLevel\":\"2\",
          \"guard\":\"False\",
          \"content\":{
            \"resources\":[\"vCPE_Infrastructure_GW_demo_app\"],
            \"identity\":\"Optimization_vCPE_Infrastructure_GW_demo_app\",
            \"policyScope\":[\"HPA\",\"vcpe_with_vgw\"],
            \"policyType\":\"hpa\",
            \"flavorFeatures\":[
              {
                \"id\":\"VDU_vgw_0\",
                \"type\":\"tosca.nodes.nfv.Vdu.Compute\",
                \"directives\":[{\"type\":\"flavor_directives\",\"attributes\":[{\"attribute_name\":\"flavorName\",\"attribute_value\":\"\"}]}],
                \"flavorProperties\":[
                  {
                    \"hpa-feature\":\"basicCapabilities\",
                    \"mandatory\":\"True\",
                    \"architecture\":\"generic\",
                    \"hpa-version\":\"v1\",
                    \"directives\":[],
                    \"hpa-feature-attributes\":[{\"hpa-attribute-key\":\"virtualMemSize\",\"hpa-attribute-value\":\"4096\",\"operator\":\"=\",\"unit\":\"MB\"}]
                  },
                  {
                    \"hpa-feature\":\"basicCapabilities\",
                    \"mandatory\":\"True\",
                    \"architecture\":\"generic\",
                    \"hpa-version\":\"v1\",
                    \"directives\":[],
                    \"hpa-feature-attributes\":[{\"hpa-attribute-key\":\"numVirtualCpu\",\"hpa-attribute-value\":\"2\",\"operator\":\"=\",\"unit\":\"\"}]
                  },
                  {
                    \"hpa-feature\":\"hugePages\",
                    \"mandatory\":\"true\",
                    \"architecture\":\"generic\",
                    \"hpa-version\":\"v1\",
                    \"directives\":[],
                    \"hpa-feature-attributes\":[{\"hpa-attribute-key\":\"memoryPageSize\",\"hpa-attribute-value\":\"2\",\"operator\":\"=\",\"unit\":\"MB\"}]
                  },
                  {
                    \"hpa-feature\":\"sriovNICNetwork\",
                    \"mandatory\":\"True\",
                    \"architecture\":\"generic\",
                    \"hpa-version\":\"v1\",
                    \"directives\":[],
                    \"hpa-feature-attributes\":[
                      {\"hpa-attribute-key\":\"pciVendorId\",\"hpa-attribute-value\":\"8086\",\"operator\":\"=\",\"unit\":\"\"},
                      {\"hpa-attribute-key\":\"pciDeviceId\",\"hpa-attribute-value\":\"154C\",\"operator\":\"=\",\"unit\":\"\"},
                      {\"hpa-attribute-key\":\"pciNumDevices\",\"hpa-attribute-value\":\"1\",\"operator\":\"=\",\"unit\":\"\"}
                    ]
                  }
                ]
              }
            ]
          }
        }"
      }'
