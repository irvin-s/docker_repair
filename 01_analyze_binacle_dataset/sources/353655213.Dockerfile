# Copyright ClusterHQ Inc.  See LICENSE file for details.
# A Flocker dataset agent image containing the EMC VNX driver and all the
# command line utilities required by that driver.
FROM clusterhq/flocker-dataset-agent:1.8.0
MAINTAINER ClusterHQ <contact@clusterhq.com>

RUN apt-get install -y sg3-utils scsitools wget
RUN wget --quiet https://github.com/emc-openstack/naviseccli/raw/master/navicli-linux-64-x86-en-us_7.33.2.0.51-1_all.deb
RUN dpkg -i navicli-linux-64-x86-en-us_7.33.2.0.51-1_all.deb
RUN /opt/flocker/bin/pip install git+https://github.com/ClusterHQ/flocker-vnx-driver.git
