# Ubuntu 12.04 (Precise) LTS with Git+Java
#
# Version 0.1
#

# Ubuntu 12.04
FROM nlothian/git
MAINTAINER Nick Lothian nick.lothian@gmail.com


RUN echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu precise main" | tee -a /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN apt-get update
RUN echo oracle-java7-installer shared/accepted-oracle-license-v1-1 select true | /usr/bin/debconf-set-selections
RUN apt-get install oracle-java7-installer -y


