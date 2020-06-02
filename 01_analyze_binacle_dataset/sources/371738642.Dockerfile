#Docker Container With Maligno, Metasploit Payload Server

#Use Kali Linux Official Docker image

FROM kalilinux/kali-linux-docker

MAINTAINER Jason Soto "www.jasonsoto.com"

ENV DEBIAN_FRONTEND noninteractive

EXPOSE 443 22

#Updates Repo and installs Maligno Dependencies
RUN apt-get update; apt-get -y --force-yes install openssl ; apt-get -y install python-ipcalc; apt-get install python-crypto

#Installs OpenSSH
RUN apt-get -y install openssh-server

#Installs Metasploit Framework
RUN apt-get -y install metasploit-framework

#Downloads And install Maligno Server
RUN wget --no-check-certificate http://www.encripto.no/tools/maligno-2.5.tar.gz
RUN tar xzvf maligno-2.5.tar.gz; cd maligno-2.5/; ./install.sh

#Adds config XML with correct metasploit Path
ADD ./server_config.xml /maligno-2.5/server_config.xml
