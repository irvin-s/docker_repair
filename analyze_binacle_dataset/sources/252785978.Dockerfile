  
FROM dkcwd/bitbucket-pipelines-php7-mysql:latest  
MAINTAINER Dave Clark "dave.clark@clarkyoungman.com"  
RUN DEBIAN_FRONTEND=noninteractive apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
pdftk \  
pdfjam  

