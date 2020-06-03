FROM alpine:3.6  
MAINTAINER Adam Dodman <"adam.dodman@gmx.com">  
  
ADD main.py /main.py  
  
RUN apk add --no-cache python3 py3-pip tini\  
&& pip3 install requests configobj  
  
VOLUME ["/config"]  
  
CMD ["/sbin/tini","--","python3","-u","main.py","-c","/config"]  

