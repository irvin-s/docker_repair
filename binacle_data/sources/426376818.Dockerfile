#// Add the Ubuntu SDK Team PPA.
RUN add-apt-repository ppa:ubuntu-sdk-team/ppa
RUN apt-get update

#// Install qtbase-opensource-src 
#// https://launchpad.net/~ubuntu-sdk-team/+archive/ppa

RUN apt-get install -y qt5-default
