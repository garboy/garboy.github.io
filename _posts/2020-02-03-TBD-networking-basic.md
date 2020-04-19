---
title:  "TCP/IP and Networking Fundamentals(TBD)"
date:   2020-02-03 21:31:18 +0800
categories: networking
---

## Back to basic 101

### OSI Overview

OSI model was designed as abstraction standard for how data should be moved within a network. It's not a protocol like DNS or HTTP that actually transacts the data. It's like a map or tunel with data starting at layer 1 and ending at layer 7.

**Layer 1 - *P*hisical**. As it says, it just phisical things, RJ45.  
**Layer 2 - *D*ata**. Switches generally resides in this layer, sometimes they function in layer 3 too.  
**Layer 3 - *N*etwork**. This is where IP addresses, routers and layer3 switches works.  
**Layer 4 - *T*ransport**. Where TCP/UDP ports resides. Network engineers generally works in layer 3 and layer 4.  
**Layer 5 - *S*ession**. Session layer is responsible for keep sessions between devices active.  
**Layer 6 - *P*resentation**. Digesting data and render it into a usable form for layer 7.  
**Layer 7 - *A*pplication**. Like its name, where application we use day to day works here.  

There's a quick memo for these: All People Seem To Need Data Processing, that is A-P-S-T-N-D-P.

### Layer 1 Phisical

Transimit electronic signal into data, vice versa, like telegraph. Device in layer 1 is hub. A hub looks like a switch, but functions totally different, and don't use it in production. This is due to how hubs handles trafic, it will send data to all other interfaces, and let other devices on hold their data sending request. This dramatically degrade the network traffic, and make it unsafe.

### Layer 2 Data

Switches generally live here, and they are not using IP addresses or packets to communicate, instead, they use frame and MAC addresses. Everytime a device connect to a switch, its MAC address is registered with the switch and held in the MAC table with the port where the device is connected to.  
When one device with IP 192.168.1.1 sends data to 192.168.1.2, it sends out an ARP request, the ARP requst takes the IP address and converted to its MAC address. With all the devices MAC address can be found on the MAC table, the data will be send to the coressponding port of switch. Unlike hub, the data will just send to the appropriate port, not to all ports. And also no more on-hold time.

Lets take an expamle. Let's say a switch has 192.168.1.1 in port 1 and 192.168.1.2 in port 4. When 1.1 needs sends data to 1.2, it sends an ARP request, and the device on port 4 responses with its MAC address. Then the switch knows it is on port 4.

There will be a big flow is when the switch cannot find a MAC in its MAC table, it will broadcast the MAC to all the ports, and update its MAC table.

### Layer 3 Network

Firewall, Router and Switches are all lives in this layer. Firewall can only lives in layer 3, but an UTM firewall can lives from layer 3 to layer 7.
