FROM python:3.5.1  
MAINTAINER Kyle P. Johnson "kyle@kyle-p-johnson.com"  
#Uncomment and change the below proxy settings if you are behind proxy.  
#ENV http_proxy http://username:password@proxy_host:proxy_port  
#ENV https_proxy http://username:password@proxy_host:proxy_port  
#ENV HTTP_PROXY http://username:password@proxy_host:proxy_port  
#ENV HTTPS_PROXY http://username:password@proxy_host:proxy_port  
RUN pip install --upgrade cltk  
RUN pip install nose  
COPY install.py install.py  
RUN python -u install.py  
RUN rm install.py  

