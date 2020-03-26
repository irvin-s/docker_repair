FROM alpine:3.7  
RUN apk add --no-cache python py-pip && \  
pip2 install komodo-python-dbgp  
  
ADD pydbgpproxy.patch /pydbgpproxy.patch  
  
RUN patch /usr/bin/pydbgpproxy /pydbgpproxy.patch  
  
CMD /usr/bin/pydbgpproxy -d 0.0.0.0:9000 -i 0.0.0.0:9001  
  
EXPOSE 9000 9001

