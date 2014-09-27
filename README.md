# Nmap-Nexpose
This is a simple wrapper for the integration of the Ruby Nmap Gem and Nexpose APIs.  The purpose of this integration is take an Nmap results xml and update our external Nexpose site to make sure they are present.

# What is Nmap?
[Nmap](http://nmap.org/) is the swiss army knife of network scanning tools that has lots of uses including scanning a large external network and identifying services
In this use case we are using an external Nmap instance as one of the ways we track of all the systems on our network that are directly accessible from the Internet.

Nmap can save it's results in an XML format, which we can easily consume and parse out to look for new systems or changes in systems open to the internet.
We will be using the Ruby Nmap gem called [ruby-nmap](https://github.com/sophsec/ruby-nmap) to prase the results XML.

# What is Nexpose?
[Nexpose](https://www.rapid7.com/products/nexpose/) is a vulnerability management platform written and made availible in multiple editions by Rapid7.  
Nexpose has the ability to run distributed scan engines to assess your systems from multiple points.  These scan engines can be hosted by an organization or can be subscribed to from Rapid7.

In this case, we are updating an Nexpose site which is associated with an external scan engine so that we are scanning all external resources and not missing anything.  You will need to get the `site_id` of the site you wish to edit.  
For more information on the Nexpose API see [Nexpose API site](https://community.rapid7.com/community/nexpose/nexpose-apis)

# Usage

## gems
``` ruby
require 'nmap'
require 'nexpose'
require 'yaml'
```

## config file
Our config file should be named `conf.yaml`, there is an example provied `example.conf.yml`
* **nmap_xml** This is your nmap scan results XML
* **nexpose_host** This is the FQDN or IP of your Nexpose instance (port is assumed 3780)
* **nexpose_user** This is a Nexpose user account that has the ability to read/write the needed sites
* **nexpose_pass** Pretty self explanatory
* **nexpose_site** This is the Nexpose siteid for the scan site you want to update

```yaml
nmap_xml: 092714_results.xml
nexpose_host: nexpose.domain.tld
nexpose_user: nxadmin
nexpose_pass: nxadmin
nexpose_site: 1
```
