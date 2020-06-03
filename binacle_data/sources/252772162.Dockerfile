FROM ecor/proxy:1.6.4  
MAINTAINER Ecor Ventures  
  
ADD ./lib /lib  
  
RUN apk update && apk add apache2-utils \  
&& chmod +x /lib/proxy \  
&& chmod +x /lib/entrypoint.sh  
  
EXPOSE 51000  
VOLUME /data/registry  
  
CMD ["/lib/entrypoint.sh"]  

