FROM alpine:3.4  
RUN apk add --update git openssh-client python py-pip \  
&& rm -rf /var/cache/apk/* \  
&& pip install --no-cache-dir docker-compose \  
&& git --version \  
&& docker-compose -v  
  
WORKDIR /var/compose  
  
ENV INTERVAL=-1 \  
REPO=required  
  
ADD run.sh /run.sh  
  
CMD ["/run.sh"]  

