import requests
import json
import httplib2
import sys

data = {
    "context": {
        "globalCustomerId": "global-customer-id-test1",
        "serviceType": "service-type-test1"
    },
    "csarId": "d5d678dc-80ef-461e-8630-d105f43b0a18",
    "nsName": "ns_vsn",
    "description": "description"
}

if len(sys.argv) < 4:
   print "please input msb ip, csar id, csar name\n"
   exit

ip = sys.argv[1]
csarid = sys.argv[2]
nsname = sys.argv[3]

data["csarId"] = csarid
data["nsName"] = nsname
print data
headers = {'content-type': 'application/json', 'accept': 'application/json'}
url = "http://" + ip + ":30280/api/nslcm/v1/ns"
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="POST", body=json.dumps(data), headers=headers)
print resp['status'], resp_content


