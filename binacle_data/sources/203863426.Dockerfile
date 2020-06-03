FROM debian:latest
MAINTAINER gabrielrcouto <gabrielrcouto@gmail.com>

# Installing packages
RUN apt-get update && apt-get upgrade -y

RUN apt-get install -y wget binutils gcc libgtk2.0-0 libgtk2.0-dev psmisc vnc4server

RUN wget http://downloads.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.6/fpc_3.0.0-151205_amd64.deb && dpkg -i fpc_3.0.0-151205_amd64.deb && rm fpc_3.0.0-151205_amd64.deb

RUN wget http://downloads.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.6/fpc-src_3.0.0-151205_amd64.deb && dpkg -i fpc-src_3.0.0-151205_amd64.deb && rm fpc-src_3.0.0-151205_amd64.deb

RUN wget http://downloads.sourceforge.net/project/lazarus/Lazarus%20Linux%20amd64%20DEB/Lazarus%201.6/lazarus_1.6-0_amd64.deb && dpkg -i lazarus_1.6-0_amd64.deb && rm lazarus_1.6-0_amd64.deb

RUN apt-get clean && apt-get autoremove -y

EXPOSE 5901