FROM alpine  
MAINTAINER Paul Pham <docker@aquaron.com>  
  
ENV _image=aquaron/anle  
  
COPY data /data-default  
  
RUN apk add -q --no-cache nginx \  
&& ln -s /data-default/bin/runme.sh /usr/bin \  
&& ln -s /data-default/bin/bash-prompt /root/.profile  
  
VOLUME /data  
ENTRYPOINT [ "runme.sh" ]  
CMD [ "daemon" ]  

