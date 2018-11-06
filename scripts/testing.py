#!/usr/bin/env python

import json
from pprint import pprint

# If the file existed prior, it gets re-written.
def dhcpd_template(dhcpdFileName, dhcpSubnet, dhcpNetmask, dhcpRangeStart, dhcpRangeEnd, router):
    with open('%s' % dhcpFileName, 'w') as f:   
        f.write("subnet %s netmask %s {\n" % (dhcpSubnet, dhcpNetmask))
        f.write("  option routers %s;\n" % router)
        f.write("  range %s %s;\n" % (dhcpRangeStart, dhcpRangeEnd))
        f.write("  next-server %s;\n\n" % router)
        f.write("  #### PXE Server IP ###\n")
        f.write("  next-server 192.168.1.1;\n")
        f.write("  filename 'pxelinux.0';\n}\n\n")
  
def testing():
    print("Hello There!!")

# This function is to create a pxeboot file for this machine.
# the file name should contain the correct mac address appended by a 01-
def createPxeFile(pxeFilePath, serverName, macAddress, ipAddress):
    print("Mine ->: %s " % pxeFilePath)
    print("Server Name: %s and ip %s" % (serverName,ipAddress))

    # Create a filename in the pxeFilePath that matches the server mac address.
    # For pxeboot to work, a '01- needs to be added to the front of the mac address.
    newMac = "01-%s" %  macAddress

    tmpMacAddress = newMac.replace(':', "-")
    print("Old Address %s New Address %s " % (macAddress, tmpMacAddress))

    # Need to create the pxefile  named the net mac address and put the contents in

# This file is to update the dhcpd.conf file to assign ip-address
# to mac address to make sure the server always gets the same
# ip address.
# This file will be rebuilt every time the call is invoked.
def updateDhcpFile(dhcpFileName, hostname, macAddress, ipAddress):
    print("This is the dhcp file -> %s " % dhcpFileName)
    
    with open('%s' % dhcpFileName, 'a') as f: 
       f.write("host %s {\n" % hostname)
       f.write("  option host-name %s;\n" % hostname)
       f.write("  hardware ethernet %s; \n" % macAddress)
       f.write("  fixed-address %s;\n}\n\n" % ipAddress)
         
    
# Gather information from the json file for all of the systems that pertain to the automation.
count = 0
with open('../conf/server-info.json','r') as f:
   y = json.load(f)

lens = len(y['servers'])

# This loop will send the appropriate information to the functions and build multiple 
# system/server files.

# system-configuration variables.
dhcpFileName    = y['file-config'][0]['dhcp-file-name']
pxeFileName     = y['file-config'][0]['pxe-file-path']
pxeFilePath     = y['dhcp-info'][0]['dhcp-subnet']
dhcpSubnet      = y['dhcp-info'][0]['dhcp-subnet']
dhcpNetmask     = y['dhcp-info'][0]['dhcp-netmask']
dhcpRouter      = y['dhcp-info'][0]['dhcp-router']
dhcpRangeStart  = (y['dhcp-info'][0]['dhcp-range-start'])
dhcpRangeEnd    = (y['dhcp-info'][0]['dhcp-range-end'])

# print("<====---- %s ----====>" % dhcpRange)
# Build the dhcpd.conf test file first.
dhcpd_template(dhcpFileName, dhcpSubnet, dhcpNetmask, dhcpRangeStart, dhcpRangeEnd, dhcpRouter)

# The below function calls will build the appropriate files.
# updateDhcpFile(dhcpFileName)
# createPxeFile(pxeFileName)

while count < lens:
    print ("Hostname: %s" % y['servers'][count]['server-name'])
    createPxeFile(pxeFileName, y['servers'][count]['server-name'], y['servers'][count]['mac-address'], y['servers'][count]['ip-address'] )
   
    # The below function calls will build the appropriate files.
    updateDhcpFile (dhcpFileName, y['servers'][count]['server-name'], y['servers'][count]['ip-address'],
           y['servers'][count]['mac-address'] )
    # First we will build the pxeboot file.  We will have to have a generic template for the dhcpd.conf file
    # And another template for the pxeboot files.    
    count += 1
