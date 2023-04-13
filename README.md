# IB-L8 

Pronounced "ablate," this project is an automation framework for Infoblox brand products built by Layer 8 (hence IB-L8). The goal of this tool is for distribution to customers to assist their engineers with the collection of data to appropriately size, architect, and deploy their new core DNS/DHCP infrastructure and DNS Security products. This tool is a facelift from P0lr's 'PAN-AF' tool utilized to create dynamic user groups on firewalls, now maintained by SKANNER-909. 

### Data Collector

The idea is to crawl your L3 environment, MS AD servers, and other devices to generate counts and sites. You will be able to input this data as well.

The logic is as follows:
1. Collect all DHCP leases from the environment
2. Collect all ARP entries from the environment (This captures devices with static IP addresses) & poll all MAC addresses in the database
3. Create table of device count to sites

### Architecture Builder

This tool will render your deployment from the above output for a variety of use cases. You will be able to edit this table to include services at each site, clusters and HA pairs, among others.

(Work in Progress)

### Deployer

(Work in Progress)

### Install on Linux (tested on RasPi w/ Python2.7):
```
wget -q https://raw.githubusercontent.com/nicknacnic/IB-L8/master/install.sh
chmod +x install.sh
./install.sh
```

### Use:
```
Browse to http://<ip>
Click on the Infoblox Logo
Click on "Setup" in the navigation menu
Enter the API keys of your available devices
Click on login
Review and edit your data
```

### That's it!
- The webserver will retain your data, and provide useful Sec/Dev Ops use cases of API automation.
- Feature requests please email to: nwilliams@infoblox.com with the subject "IB-L8 Feature Request"

### BONUS
So much automation!
