import requests
import json
import httplib2
import sys

data = {
    "csarId": "d5d678dc-80ef-461e-8630-d105f43b0a18"
}

if len(sys.argv) < 3:
   print "please input msb ip, csar id\n"
   exit

# msb-iag ip
ip = sys.argv[1]
csarid = sys.argv[2]

data["csarId"] = csarid
print data
headers = {'content-type': 'application/json', 'accept': 'application/json'}
url = "http://" + ip + ":30280/api/catalog/v1/vnfpackages"
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="POST", body=json.dumps(data), headers=headers)
print resp['status'], resp_content


