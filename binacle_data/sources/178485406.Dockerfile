FROM ubuntu:15.04
MAINTAINER Carl Boettiger <cboettig@gmail.com>

## Set environment
ENV TERM xterm
ENV BCE_USER ubuntu
ENV BCE_VERSION 2015-fall

## Set Locales
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8 

## Copy over files to the locations expected by the BCE provisioning scripts
COPY . /tmp 
RUN useradd $BCE_USER && \
	mkdir /home/$BCE_USER && \
  mv /tmp/dot-config /home/$BCE_USER/.config && \
  mv /tmp/dot-local /home/$BCE_USER/.local && \
  mv /tmp/plymouth-theme /tmp/bce && \
  mv /tmp/guest-scripts/setup_ipython_notebook.sh /home/$BCE_USER/ && \
  mv /tmp/guest-scripts/update-bce-docs /tmp/ && \
  chown -R $BCE_USER:$BCE_USER /home/$BCE_USER

## Install missing packages, configure debconf.selections and the run provisioner
RUN cd /tmp && \
	DEBIAN_FRONTEND=noninteractive && DEBIAN_PRIORITY=high \
	apt-get update -qq && apt-get install -yq --no-install-recommends \
		apt-transport-https \
		ca-certificates \
		debconf-utils \
                dnsutils \
		etckeeper \
		lsb-release \
		nano \
		sudo && \
	bzr whoami "BCE Release Team <bce@lists.berkeley.edu>" && \
	debconf-set-selections < debconf.selections && \
	bash /tmp/bootstrap-bce.sh 


## Consider: adding jupyter and rstudio-server to path
## Extending with more R packages
EXPOSE 9999 
EXPOSE 8787

