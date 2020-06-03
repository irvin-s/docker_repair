FROM debian:jessie  
  
MAINTAINER Bruno Binet <bruno.binet@helioslite.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get install -yq --no-install-recommends python-pip  
RUN pip install waitress hooked==0.3  
  
ADD hooked.cfg /etc/hooked.cfg  
  
VOLUME ["/config"]  
  
EXPOSE 80  
CMD ["hooked", "/config/hooked.cfg"]  

