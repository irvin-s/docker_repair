FROM ubuntu:trusty  
  
MAINTAINER David Kelley <hello@davidkelley.me>  
  
# Ensure latest packages installed  
RUN apt-get update  
RUN apt-get install -y wget default-jre-headless  
  
# Download Riemann 0.2.5  
RUN wget http://aphyr.com/riemann/riemann-0.2.5.tar.bz2  
RUN tar xvfj riemann-0.2.5.tar.bz2  
  
# Perform md5 checksum validation  
RUN wget http://aphyr.com/riemann/riemann-0.2.5.tar.bz2.md5  
RUN md5sum -c riemann-0.2.5.tar.bz2.md5  
  
# Inject the hostname into the hosts file  
# RUN echo 127.0.0.1 `hostname -s` >> /etc/hosts  
# Ensure riemann folder is the working directory  
WORKDIR /riemann-0.2.5  
  
# Expose Riemann's ports  
EXPOSE 5555  
EXPOSE 5555/udp  
EXPOSE 5556  
# Bind to Docker interface  
RUN sed -i -e "s|127.0.0.1|0.0.0.0|" etc/riemann.config  
  
ENTRYPOINT ["bin/riemann", "etc/riemann.config"]  
  

