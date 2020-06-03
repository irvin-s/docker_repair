FROM smebberson/alpine-nginx  
  
ENV GO_DNSMASQ_LOG_FILE /var/log/go_dnsmask.log  
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \  
ln -sf /dev/stderr /var/log/nginx/error.log  
RUN apk update && apk add curl python py-pip  
RUN pip install envtpl==0.5.3  
  

