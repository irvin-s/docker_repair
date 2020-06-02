FROM billyboingo/docker-oracle-jdk:java8  
MAINTAINER Bill Weiss <billyboingo@gmail.com>  
  
#Install the tools we will need  
RUN apt-get -q update && apt-get install -qy --force-yes \  
wget \  
unzip  
  
#Download and install latest NX Filter  
ENV NXF_VERSION 4.1.8  
ENV NXF_NAME nxfilter-$NXF_VERSION  
ENV NXF_FILE $NXF_NAME.zip  
ENV NXF_URL http://nxfilter.org/download/$NXF_FILE  
  
RUN wget -nv -P /tmp $NXF_URL  
RUN unzip /tmp/$NXF_FILE -d /app && \  
chmod +x /app/bin/startup.sh && \  
ln -s /config /app/db  
  
#Clean up  
RUN apt-get -y autoremove; apt-get clean && \  
rm -rf /var/lib/apt/lists/* && \  
rm -rf /tmp/*  
  
#Adding Custom files  
COPY services/ /etc/service/  
RUN chmod -v +x /etc/service/*/run  
  
#Mappings and Ports  
VOLUME ["/config"]

