import requests
import json
import httplib2
import sys

data = {
    "additionalParamForNs": {
        "sdnControllerId": "2"
    },
    "locationConstraints": [{
        "vnfProfileId": "3fca3543-07f5-492f-812c-ed462e4f94f4",
        "locationConstraints": {
            "vimId": "INTEL_ONAP-POD-01-Rail-07"
        }
    }]
}

if len(sys.argv) < 2:
   print "please input msb ip, ns_instance_id, vnf_description_id\n"
   exit

ip = sys.argv[1]
nsInstanceId = sys.argv[2]
#vnfProfileId = sys.argv[3]

#data["locationConstraints"][0]["locationConstraints"]["vimId"] = vimid
#if vnfProfileId:
#    data["locationConstraints"]["vnfProfileId"] = vnfProfileId

headers = {'content-type': 'application/json', 'accept': 'application/json'}
http = httplib2.Http()
url = "http://" + ip + ":30280/api/nslcm/v1/ns/" + nsInstanceId + "/instantiate"
print url
resp, resp_content = http.request(url, method="POST", body=json.dumps(data), headers=headers)
print resp['status'], resp_content




