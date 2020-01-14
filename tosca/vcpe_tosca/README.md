# vCPE_tosca

5 VNFs are here for ONAP vCPE use case. These VNFD are transformed manually from vCPE heat template. 

Please run ./generate_csar.sh to create the csar package files for these 5 VNFS. CSAR package file is just a zip file.

## pending issues to DM
Please search for "TODO" in the corresponding VNFD to find the pending things.
- HPA detailed format
- ~~VDU local disk size(Done.)~~
- ~~VDU metadata(Done.)~~
- ~~VDU cloudinit(Done.)~~
- ~~image name in glance for VDU(Done.)~~

## References:
- [vCPE use case](https://wiki.onap.org/pages/viewpage.action?pageId=3246168)
- [vCPE usage tutorial for A release](https://wiki.onap.org/display/DW/vCPE+Use+Case+Tutorial%3A+Design+and+Deploy+based+on+ONAP+Amsterdam+Release) Based on heat.
