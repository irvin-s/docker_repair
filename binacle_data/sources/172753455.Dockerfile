FROM concourse/atc-ci

# install virtualbox
RUN echo 'deb http://download.virtualbox.org/virtualbox/debian xenial contrib' >> /etc/apt/sources.list
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get -y --force-yes install virtualbox-5.1

# install 'lsmod' so virtualbox can detect vboxdrv module is loaded
# have to install oder libkmod2 package for this atm
RUN apt-get -y --force-yes install libkmod2 module-init-tools

# for making Virtualbox's hostonlyifs work since it shells to ifconfig
RUN apt-get update && apt-get -y install net-tools

# install Vagrant
ADD https://releases.hashicorp.com/vagrant/1.8.5/vagrant_1.8.5_x86_64.deb /tmp/vagrant.deb
RUN dpkg -i /tmp/vagrant.deb && rm /tmp/vagrant.deb
