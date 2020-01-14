import requests
import json
import httplib2
import sys

data = {}

headers = {'content-type': 'application/json', 'accept': 'application/json'}
url = "http://10.12.5.155:30280/api/nslcm/v1/ns/fdf71f54-0ef9-4a2e-8b73-cef8a7e8b08e"
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="DELETE", body=json.dumps(data), headers=headers)
print resp['status'], resp_content

