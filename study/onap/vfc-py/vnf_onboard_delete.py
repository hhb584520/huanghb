import requests
import json
import httplib2
import sys

data = {}

headers = {'content-type': 'application/json', 'accept': 'application/json'}
api = "/api/catalog/v1/vnfpackages/"
#csar_id = "34af6038-9aea-4e6e-815e-e2f1d1fb7fd6"
#csar_id = "656c1bc8-574e-4795-96b6-41e936aea21a"
#csar_id = "693bd64e-eecb-4d36-a392-2c2b3a21f916"
#csar_id = "6a4cbbbc-f736-479b-8cd2-d690c8221001"
#csar_id = "730d1e3a-a826-4f37-afa7-5913b4b7ee2a"
#csar_id = "76f6bd5e-6ed2-4448-bab7-829e76fd0104"
#csar_id = "ee342ac6-4325-4830-9b2f-cc244cf4d682"
csar_id = "1fdd7a9b-829a-4b79-bf83-87b0770f71c9"
url = "http://10.12.5.155:30280" + api + csar_id
print url
http = httplib2.Http()
resp, resp_content = http.request(url, method="DELETE", body=json.dumps(data), headers=headers)
print resp['status'], resp_content

