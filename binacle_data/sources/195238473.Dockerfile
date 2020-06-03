FROM ubuntu:14.04

MAINTAINER Iliyan Trifonov <iliyan.trifonov@gmail.com>

#use mirrors for faster apt downloads no matter where the machine that builds the image is
RUN echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty main restricted universe multiverse" > /etc/apt/sources.list; \
	echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-updates main restricted universe multiverse" >> /etc/apt/sources.list; \
	echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-backports main restricted universe multiverse" >> /etc/apt/sources.list; \
	echo "deb mirror://mirrors.ubuntu.com/mirrors.txt trusty-security main restricted universe multiverse" >> /etc/apt/sources.list

#install required software before using nvm/node/npm/bower
RUN apt-get update && apt-get install -y curl git python build-essential

#add user node and use it to install node/npm and run the app
RUN useradd --home /home/node -m -U -s /bin/bash node

#allow some limited sudo commands for user `node`
RUN echo 'Defaults !requiretty' >> /etc/sudoers; \
    echo 'node ALL= NOPASSWD: /usr/sbin/dpkg-reconfigure -f noninteractive tzdata, /usr/bin/tee /etc/timezone, /bin/chown -R node\:node /myapp' >> /etc/sudoers;

#run all of the following commands as user node from now on
USER node

RUN curl https://raw.githubusercontent.com/creationix/nvm/v0.33.1/install.sh | bash

#change it to your required node version
ENV NODE_VERSION 7.6.0

#needed by nvm install
ENV NVM_DIR /home/node/.nvm

#install the specified node version and set it as the default one, install the global npm packages
RUN . ~/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && npm install -g bower pm2 --user "node"

#on container's boot the run script will update/install all required npm/bower packages for the app and run the app
ADD ./run_all.sh /run_all.sh

#exposes port 3000 but your app may use any port specified in it
EXPOSE 3000

#/run_all.sh does everything required on container's boot
CMD ["/bin/bash", "/run_all.sh"]
