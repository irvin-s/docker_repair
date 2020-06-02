## Start with the official rocker image (lightweight Debian)  
FROM rocker/r-base:latest  
  
MAINTAINER Gergely Daroczi <gergely.daroczi@card.com>  
  
## add support for HTTPS-based repos  
RUN apt-get update && apt-get install -y apt-transport-https \  
&& apt-get clean && rm -rf /var/lib/apt/lists/  
  
## use Amazon's HTTPS Debian repo  
RUN echo 'deb https://cloudfront.debian.net/debian/ testing main\n\  
deb https://cloudfront.debian.net/debian/ testing-updates main\n\  
deb https://cloudfront.debian.net/debian-security/ testing/updates main\n'\  
| tee /etc/apt/sources.list \  
&& echo "deb https://cloudfront.debian.net/debian/ sid main" \  
| tee /etc/apt/sources.list.d/debian-unstable.list  

