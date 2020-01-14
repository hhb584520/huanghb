#!/bin/sh

ssh onap@onap-1.sc.intel.com -L 1080:10.7.211.16:1080
wget --no-proxy www.google.com

