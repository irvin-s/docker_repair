FROM ubuntu:14.04
RUN apt-get -y update \
    && apt-get -y install python3-pip \
       	       	  	  git
RUN pip3 install docker
RUN git clone https://github.com/h-m-s/telnet-honeypot.git
RUN mkdir -p /var/log/hms/
CMD sudo python3 /telnet-honeypot/telnet.py
