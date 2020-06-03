FROM nginx  
  
COPY ./openssl/ /tmp/openssl/  
RUN /tmp/openssl/generate.sh  
  
COPY ./upstreams.conf /etc/nginx/conf.d/upstreams.conf  
COPY ./default.conf /etc/nginx/conf.d/default.conf  
COPY ./proxy.conf /etc/nginx/proxy.conf  
  
RUN bash  

