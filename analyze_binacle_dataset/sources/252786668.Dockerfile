FROM sameersbn/squid:latest  
MAINTAINER Denis Pettens <denis.pettens@gmail.com>  
  
# Install apache2-utils for authentification program  
RUN set -x \  
&& apt-get update \  
&& DEBIAN_FRONTEND=noninteractive apt-get install -y apache2-utils \  
&& rm -rf /var/lib/apt/lists/*  
# Create file for store http proxy users  
RUN set -x \  
&& touch /etc/squid3/users  

