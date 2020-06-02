FROM ubuntu:14.04

# update system
RUN apt-get update
RUN apt-get -y --force-yes upgrade
RUN apt-get -y --force-yes autoclean
RUN apt-get -y --force-yes autoremove --PURGE

# create non-root user
RUN useradd -m casperbox

# install wget
RUN apt-get install -y --force-yes wget

# install nodejs
RUN wget http://nodejs.org/dist/v0.10.26/node-v0.10.26-linux-x64.tar.gz
RUN gunzip node-v0.10.26-linux-x64.tar.gz
RUN tar -xf node-v0.10.26-linux-x64.tar
RUN rm node-v0.10.26-linux-x64.tar
RUN mv node-v0.10.26-linux-x64 node
RUN chown -R casperbox:casperbox node
RUN mv node ~casperbox

# install phantomjs
RUN wget --no-check-certificate https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN apt-get install -y --force-yes bzip2
RUN bunzip2 phantomjs-1.9.7-linux-x86_64.tar.bz2
RUN tar -xf phantomjs-1.9.7-linux-x86_64.tar
RUN rm phantomjs-1.9.7-linux-x86_64.tar
RUN mv phantomjs-1.9.7-linux-x86_64 phantomjs
RUN chown -R casperbox:casperbox phantomjs
RUN mv phantomjs ~casperbox

# install casperjs
RUN wget --no-check-certificate https://github.com/n1k0/casperjs/zipball/1.1-beta3
RUN apt-get install -y --force-yes unzip
RUN unzip 1.1-beta3
RUN rm 1.1-beta3
RUN mv *casperjs* casperjs
RUN chown -R casperbox:casperbox casperjs
RUN mv casperjs ~casperbox

# install python & libs
RUN apt-get install -y --force-yes python libfreetype6 libfontconfig1
