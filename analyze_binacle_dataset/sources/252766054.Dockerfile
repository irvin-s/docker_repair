FROM debian:8.3  
MAINTAINER Niels Ulrik Andersen <niels@myplace.dk>  
  
RUN apt-get update -q \  
&& apt-get install -qy \  
deluge-common=1.3.10-* \  
&& rm -rf /var/lib/apt/lists/* \  
;  

