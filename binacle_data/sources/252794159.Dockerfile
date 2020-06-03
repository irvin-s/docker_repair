FROM darron/hugo-caddy  
MAINTAINER Darron Froese <darron@froese.org>  
  
ADD . /srv  
  
WORKDIR /srv  
  
RUN hugo  
  
EXPOSE 2020  
CMD caddy  

