############################################################
# Dockerfile to run Logstash
# Based on Ubuntu Image
############################################################

# Set the base image to use to Ubuntu
FROM ubuntu

# Set the file maintainer (your name - the file's author)
MAINTAINER Igor Barinov

# Update the default application repository sources list
RUN sudo apt-get update

# Install JRE
RUN sudo apt-get install -y default-jre

# CD
RUN cd /root

RUN sudo apt-get install -y wget
# donwload logstash
RUN wget -P /root https://download.elasticsearch.org/logstash/logstash/logstash-1.5.0.tar.gz
# unpack
RUN tar -zxvf /root/logstash-1.5.0.tar.gz -C /root
RUN rm /root/logstash-1.5.0.tar.gz

# test it
#RUN cd logstash-1.5.0

# Copy file
COPY ./insight.conf /root/logstash-1.5.0/insight.conf

##################### INSTALLATION END #####################

# Expose the default port
EXPOSE 28777

ENTRYPOINT /root/logstash-1.5.0/bin/logstash -f /root/logstash-1.5.0/insight.conf

#ENTRYPOINT ls /root/logstash-1.5.0
