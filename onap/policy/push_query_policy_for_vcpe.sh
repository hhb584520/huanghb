curl -k -v -X PUT 'https://pdp:8081/pdp/api/pushPolicy' \
 --header 'Content-Type: application/json' \
 --header 'Accept: text/plain' \
 --header 'ClientAuth: cHl0aG9uOnRlc3Q=' \
 --header 'Authorization: Basic dGVzdHBkcDphbHBoYTEyMw==' \
 --header 'Environment: TEST' \
 -d '{
       "pdpGroup": "default",
       "policyName": "OSDF_VFC.QueryPolicy_VCPE_with_vgw",
       "policyType": "MicroService"
    }'
