FROM debian:jessie-backports  
MAINTAINER Cheewai Lai <clai@csir.co.za>  
  
#  
# Not using nginx because addon modules requires compilation from source  
#  
ARG DEBIAN_FRONTEND=noninteractive  
RUN apt-get update \  
&& apt-get -y install wget \  
&& wget -O - http://ftp.debian-ports.org/archive/archive_2013.key | apt-key
add - \  
&& apt-get -y dist-upgrade \  
&& apt-get -y install libxml2 apache2 apache2-utils \  
&& a2enmod proxy proxy_html proxy_http xml2enc \  
&& a2dissite 000-default \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  

