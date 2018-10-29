#!/usr/bin/env python

import json
from pprint import pprint


def testing():
    print("Hello There!!")

# This function is to create a pxeboot file for this machine.
# the file name should contain the correct mac address appended by a 01-
def createPxeFile(pxefilename):
    print("Mine")

# This file is to update the dhcpd.conf file to assign ip-address
# to mac address to make sure the server always gets the same
# ip address.
def updateDhcpFile(dhcpFileName):
    print("This")
    with open('%s' % dhcpFileName, 'w') as f:
        f.writelines
    

# Gather information from the json file for all of the systems that pertain to the automation.
count = 0
with open('../conf/server-info.json','r') as f:
   y = json.load(f)

lens = len(y['servers'])

# This loop will send the appropriate information to the functions and build multiple 
# system/server files.
while count < lens:
    print ("Hostname: %s" % y['servers'][count]['server-name'])

   # First we will build the pxeboot file.  We will have to have a generic template for the dhcpd.conf file
   # And another template for the pxeboot files.
   
    
    
    count += 1

# print("Finale --->")
# pprint(y)


