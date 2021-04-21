import requests
import json
import httplib2
import sys

data = {}

headers = {'content-type': 'application/json', 'accept': 'application/json'}
#url = "http://10.12.5.155:30280/api/nslcm/v1/ns/d0ecc83f-339f-4621-b565-07eb9090a379/terminate"
url = "http://10.12.5.155:30280/api/nslcm/v1/ns/f5bebc27-68dd-487b-9b90-be9012e363c6/terminate"
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="POST", body=json.dumps(data), headers=headers)
print resp['status'], resp_content

