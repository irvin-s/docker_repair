FROM java:8  
MAINTAINER Bart1ebee  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \  
unzip \  
curl \  
wget \  
&& apt-get clean  
  
RUN mkdir -p /data  
COPY ./start-phantombot.sh /  
COPY ./botlogin.txt /  
RUN apt-get clean && rm -rf /var/cache/apt/archives/* /var/lib/apt/lists/*  
  
RUN chmod +x /start-phantombot.sh  
  
EXPOSE 25000 25001 25002 25005  
VOLUME ["/data"]  
  
ENTRYPOINT ["/start-phantombot.sh"]  

