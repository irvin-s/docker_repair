FROM ceroic/kubectl:latest  
MAINTAINER Ceroic <ops@ceroic.com>  
  
RUN curl -s https://get.helm.sh | bash  
RUN mv helmc /usr/bin  
  
WORKDIR /root  
COPY docker-entrypoint.sh /  
  
# Initialize helm so it creates the working directories  
RUN helmc repository list  
  
ENTRYPOINT ["/docker-entrypoint.sh"]

