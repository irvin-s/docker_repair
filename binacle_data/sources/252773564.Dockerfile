FROM ubuntu:14.04  
RUN apt-get update \  
&& apt-get install -y wget \  
&& apt-get install -y unzip  
RUN wget https://github.com/obfuscurity/synthesize/archive/master.zip \  
&& unzip master.zip \  
&& cd synthesize-master \  
&& ./install  
EXPOSE 80 2003

