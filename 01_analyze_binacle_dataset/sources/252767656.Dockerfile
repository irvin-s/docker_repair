FROM debian:latest  
MAINTAINER adam.olenderski@gmail.com  
RUN apt-get update && apt-get install -y man less vim curl wget sendemail sudo  
RUN adduser --home /home/ace --shell /bin/bash ace && usermod -G sudo ace  
USER ace  
RUN echo set -o vi >> ~/.bashrc && \  
echo export PAGER=less >> ~/.bashrc && \  
echo export VISUAL=vi >> ~/.bashrc && \  
echo export EDITOR=vi >> ~/.bashrc  
WORKDIR /home/ace  

