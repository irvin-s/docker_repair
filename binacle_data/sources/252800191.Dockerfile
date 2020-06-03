# VERSION 0.1  
FROM java:8  
MAINTAINER Dirk Kirsten, <dk@basex.org>  
  
# Download latest BaseX release  
RUN apt-get install curl unzip  
RUN curl http://files.basex.org/releases/8.2/BaseX82.zip -o /tmp/BaseX.zip  
RUN unzip /tmp/BaseX.zip -d /opt/  
RUN mkdir /data /repo /webapp  
  
# Define mountable directories.  
VOLUME ["/data", "/repo", "/webapp"]  
  
# Define working directory.  
WORKDIR /opt/basex  
RUN pwd  
COPY .basex /opt/basex/.basex  
  
# Expose port.  
EXPOSE 8984  
EXPOSE 1984  
# Define default command.  
ENTRYPOINT ["/opt/basex/bin/basexhttp"]  

