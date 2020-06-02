FROM php:7-alpine  
  
LABEL maintainer "nicolas.potier@acseo.fr"  
  
RUN curl -LO https://deployer.org/deployer.phar \  
&& mv deployer.phar /usr/local/bin/dep \  
&& chmod +x /usr/local/bin/dep  
  
RUN apk --no-cache add openssh-client rsync  
  
ENTRYPOINT ["/bin/sh", "-c"]  

