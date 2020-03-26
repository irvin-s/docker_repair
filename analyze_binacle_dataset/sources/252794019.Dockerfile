FROM almir/webhook  
  
MAINTAINER Frederic Darmstädter <docker@darmstaedter.org>  
  
COPY hooks.json /etc/webhook/hooks.json  
COPY redeploy-webhook.sh /etc/webhook/redeploy-webhook.sh  
RUN chmod +x /etc/webhook/redeploy-webhook.sh && \  
apk update && \  
apk upgrade && \  
apk add \--no-cache bash git openssh-client  
CMD ["-verbose", "-verbose", "-hooks=/etc/webhook/hooks.json", "-hotreload"]  

