import requests
import sys

#if len(sys.argv) < 3:
#   print "please input msb ip\n"
#   exit

# ip = sys.argv[1]
# api = sys.argv[2]
ip = "10.12.5.155"
api = "/api/nslcm/v1/ns"
# api = "/api/nsd/v1/ns_descriptors"
# /api/vnfpkgm/v1/vnf_packages
# /api/catalog/v1/vnfpackages
# /api/catalog/v1/nspackages

url = "http://" + ip + ":30280" + api
print url

resp = requests.get(url)
print resp.status_code, resp.json()

