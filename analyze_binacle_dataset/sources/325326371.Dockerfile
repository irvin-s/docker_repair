FROM ubuntu:latest

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update -y && \
apt-get install -y \
git \
xvfb \
x11vnc \
wget \
python \
python-numpy \
unzip \
menu \
geany \
openbox \
net-tools \
geany \
menu \
openjdk-8-jre \
firefox &&  wget -qO- https://get.docker.com | sh

Run cd /root && git clone https://github.com/kanaka/noVNC.git && \
cd noVNC/utils && git clone https://github.com/kanaka/websockify websockify && \
cd /root

ADD startup.sh /startup.sh

RUN chmod 0755 /startup.sh && \
apt-get autoclean && \
apt-get autoremove && \
rm -rf /var/lib/apt/lists/*

CMD /startup.sh
