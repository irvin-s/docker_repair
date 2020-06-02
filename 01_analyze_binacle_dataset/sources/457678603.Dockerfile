FROM ubuntu:bionic

#Base settings
ENV HOME /root

#Install needed packages
RUN apt update && apt install -y python3 python3-dev python3-pip tor locales nano sqlite3

RUN sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  

WORKDIR /srv/
ADD ./requirements.txt /srv/requirements.txt
RUN pip3 install -r requirements.txt

WORKDIR /root/
#Add Onionr source
COPY . /root/
VOLUME /root/data/

#Set upstart command
CMD bash

#Expose ports
EXPOSE 8080
