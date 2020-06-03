FROM asteris/consul-template:latest  
  
ENV REFRESHED_AT 2015-05-27v4  
MAINTAINER Andrew Grande <aperepel@gmail.com>  
  
ENV CONSUL_URL=172.17.42.1:8500  
# Alpine Linux didn't publish HAProxy 1.5.x in main repos yet  
RUN echo http://dl-4.alpinelinux.org/alpine/edge/main > /tmp/new_repo  
RUN apk update --repositories-file /tmp/new_repo  
RUN apk add --repositories-file /tmp/new_repo haproxy openssl-dev  
  
WORKDIR /consul-template  
ADD haproxy.cfg.tmpl ./  
ADD conf/run.sh /tmp/  
RUN chmod +x /tmp/run.sh  
  
EXPOSE 80  
ENTRYPOINT ["/tmp/run.sh"]  

