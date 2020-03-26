FROM ubuntu  
MAINTAINER Matthieu Mota <matthieumota@gmail.com>  
  
RUN apt-get update && apt-get install -y curl php-cli  
  
RUN curl -LsS https://symfony.com/installer -o /usr/local/bin/symfony  
RUN chmod a+x /usr/local/bin/symfony  
  
VOLUME ["/app"]  
WORKDIR /app  
  
ENTRYPOINT ["symfony"]

