#!/usr/bin/python
__author__ = " Zhou Chao"

#NOTICE: please install or copy this fill to $XVS_ROOT/lib/
#modifier: Benyu Xu

import re,sys,os,string,glob
from optparse import OptionParser

usage = "usage: %prog [options] arg"
parser = OptionParser(usage=usage)
parser.add_option("-a", "--all", dest="allinfo", action="store_true",
                   help="show all network devices status of the platform")
parser.add_option("-i", "--interface", dest="interfaceinfo", action="store", metavar="INTERFACE",
                   help="show the network devices status of specified interface")
parser.add_option("-b", "--bdf", dest="bdfinfo", action="store", metavar="BDF",
                   help="show the network devices status of specified BDF")
parser.add_option("-m", "--model", dest="modelinfo", action="store", metavar="MODEL",
                   help="show the network devices status of specified MODEL")
parser.add_option("-d", "--avdevice", dest="availableinfo", action="store", metavar="AVAILABLE",
                   help="show the available devices on the platform, ONLY <PF, VF, NIC> available")

# for test
parser.add_option("-w", "--wtdevice", dest="wantedinfo", action="store", metavar="WANTED",
                   help="show the wanted devices on the platform, ONLY <PF, VF, NIC> wanted")
#
parser.add_option("-v", "--verbose", dest="verbose", action="store_true", default = True,
		   help="print all the messages, DEFAULT_VALUE=TRUE") 
parser.add_option("-q", "--quite", dest="verbose", action="store_false",
		   help="ONLY print BDF")
(options, args) = parser.parse_args()

class Net_Dev:
	def __init__(self,**args):
		self.driver=args['driver']
		self.bdf=args['bdf']
		self.state=args['state']
		self.interface=args['interface']
		self.vf_list=args['vf_list']
		self.device_model=args['device_model']
		self.device_type=args['device_type']
		self.parent=args['parent']
		self.mac=args['mac']

def parse_cmd(cmd):
	output=os.popen(cmd)
	return output.read()

def show_all():
        for k,v in net_list[bdf].__dict__.items():
                print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
        print "\n"

def show_interface(para):
	if interface == para.lower():
		for k,v in net_list[bdf].__dict__.items():
			print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
		sys.exit(0)
def show_bdf(para):
	if bdf == para:
		for k,v in net_list[bdf].__dict__.items():
                        print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
		sys.exit(0)
def show_model(para, para1=None):
	if para.upper() in device_model and para1.upper() == None:
		for k,v in net_list[bdf].__dict__.items():
                        print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
		print "\n"
	elif para.upper() in device_model and para1.upper() == device_type and state == "Available":
		for k,v in net_list[bdf].__dict__.items():
                        print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
                print "\n"
def show_short_model(para, para1=None):
	if para.upper() in device_model and para1.upper() == None:
		for k,v in net_list[bdf].__dict__.items():
			if (k == "bdf"):
                                print v
	elif para.upper() in device_model and para1.upper() == device_type and state == "Available":
		for k,v in net_list[bdf].__dict__.items():
                        if (k == "bdf"):
                                print v
def show_available(para):
	if (para.upper() == device_type and state == "Available"):
		for k,v in net_list[bdf].__dict__.items():
				print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
		print "\n"
def show_short_available(para):
	if (para.upper() == device_type and state == "Available"):
                for k,v in net_list[bdf].__dict__.items():
                        if (k == "bdf"):
                                print v
def show_wanted(para):
	if (para.upper() == device_type):# and state == "Available"):
		for k,v in net_list[bdf].__dict__.items():
				print '\033[1;32;40m'+k+'\033[0m'+'='+str(v)
		print "\n"
def show_short_wanted(para):
	if (para.upper() == device_type):# and state == "Available"):
                for k,v in net_list[bdf].__dict__.items():
                        if (k == "bdf"):
                                print v


output=parse_cmd("lspci | grep Eth")
output1=parse_cmd("route -n | grep 192.168.199")
output2=parse_cmd("brctl show")
net_list={}
for line in output.strip().split('\n'):
	vf_list=[]
	driver=None
	bdf=None
	state="Available"
	interface=None
	device_model=None
	device_type=None
	parent=None
	mac=None
	line_list=line.split(' ')
	bdf=line_list[0]
	dir_path="/sys/bus/pci/devices/0000:" + bdf
	if os.path.exists(dir_path):
		pci_msg=parse_cmd("lspci -mm -s " + bdf)
		device_model=pci_msg.split(' "')[3].split('"')[0]
		if os.path.exists(dir_path + '/sriov_totalvfs'):
			device_type="PF"
			vf=glob.glob(dir_path + '/virtfn*')
			if vf:
				state="USED"
			for ele in vf:
				vf_list.append(os.readlink(ele).split('/0000:')[-1])
		elif os.path.exists(dir_path + '/physfn'):
			device_type="VF"
			parent=os.readlink(dir_path + '/physfn').split('/0000:')[-1]
			#state=net_list[parent].state
		else:
			device_type="NIC"
		if os.path.exists(dir_path + '/driver'):
			driver=os.readlink(dir_path + '/driver').split('/')[-1]
			if (driver == "virtio-pci" or driver == "vfio-pci" or driver == "pci-stub" or driver == "pciback" or driver == "xen-platform-pci"):
				state="USED"
			else:
				if os.path.exists(dir_path + '/net'):
					interface=os.listdir(dir_path + '/net')[0]
					# check if the interface in bridge/route or if it's physically linked
					if (interface in output2):
						state="USED"
					elif (interface in output1 and device_type != "VF"):
						state="USED"
					elif ("NO-CARRIER" in parse_cmd("ip link show " + interface)):
						state="UNLINK"
					mac=open(dir_path + '/net/' + interface + '/address').read( ).strip()
	
	net=Net_Dev(driver=driver,bdf=bdf,state=state,interface=interface,vf_list=vf_list,device_model=device_model,device_type=device_type,parent=parent,mac=mac)
	net_list.update({bdf:net})
	
	if options.allinfo:
        	show_all()
	elif options.interfaceinfo:
		if options.interfaceinfo.lower() in parse_cmd("ifconfig -a"):
			show_interface(options.interfaceinfo)
		else:
			print "No interfance found"
			sys.exit(1)
	elif options.bdfinfo:
		if options.bdfinfo in output:
			show_bdf(options.bdfinfo)
		else:
			print "No BDF found"
			sys.exit(1)
	elif options.modelinfo:
		if options.modelinfo.upper() in output:
			if options.verbose:
				if options.availableinfo.upper() in ["PF","VF","NIC"]:
					show_model(options.modelinfo, options.availableinfo)
				else:
					show_model(options.modelinfo)
			else:
				if options.availableinfo.upper() in ["PF","VF","NIC"]:
					show_short_model(options.modelinfo, options.availableinfo)
				else:
					show_short_model(options.modelinfo)
		else:
			print "No Device Model found"
			sys.exit(1)
	elif options.availableinfo:
		if options.availableinfo.upper() in ["PF","VF","NIC"]:
			if options.verbose:
				show_available(options.availableinfo)
			else:
				show_short_available(options.availableinfo)
		else:
			print "You really should use either \"PF\", \"VF\" or \"NIC\""
			sys.exit(1)
	elif options.wantedinfo:
		if options.wantedinfo.upper() in ["PF","VF","NIC"]:
			if options.verbose:
				show_wanted(options.wantedinfo)
			else:
				show_short_wanted(options.wantedinfo);
		else:
			print "You really should use either \"PF\", \"VF\" or \"NIC\""
			sys.exit(1)

	else:
		show_all()


