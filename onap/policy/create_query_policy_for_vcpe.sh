curl -k -v  -X PUT 'https://pdp:8081/pdp/api/createPolicy' \
 --header 'Content-Type: application/json' \
 --header 'Accept: text/plain' \
 --header 'ClientAuth: cHl0aG9uOnRlc3Q=' \
 --header 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' \
 --header 'Environment: TEST' \
 -d '{
    "configBody": "{\"service\": \"queryPolicy\", \"guard\": \"False\", \"content\": {\"policyType\": \"request_param_query\", \"queryProperties\": [{\"attribute\": \"customerLatitude\", \"attribute_location\": \"customerLatitude\"}, {\"attribute\": \"customerLongitude\", \"attribute_location\": \"customerLongitude\"}], \"identity\": \"vCPE_with_vgw_Query_Policy\", \"serviceName\": \"VCPE_with_vgw\", \"policyScope\": [\"vcpe_with_vgw\", \"us\", \"international\", \"ip\"]}, \"priority\": \"3\", \"templateVersion\": \"OpenSource.version.1\", \"riskLevel\": \"2\", \"description\": \"Query policy for vCPE\", \"policyName\": \"OSDF_VFC.QueryPolicy_VCPE_with_vgw\", \"version\": \"1.0\", \"riskType\": \"test\"}",
    "policyName": "OSDF_VFC.QueryPolicy_VCPE_with_vgw",
    "policyConfigType": "MicroService",
    "onapName": "SampleDemo",
    "policyScope": "OSDF_VFC"
}'
