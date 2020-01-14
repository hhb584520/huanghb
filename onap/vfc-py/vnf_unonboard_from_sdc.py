import requests
import json
import httplib2
import sys

data = {}

headers = {'content-type': 'application/json', 'accept': 'application/json'}
url = "http://10.12.5.155:30280/api/catalog/v1/vnfpackages/af59a474-6391-4500-989c-f78df18d77f0"
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="DELETE", body=json.dumps(data), headers=headers)
print resp['status'], resp_content

