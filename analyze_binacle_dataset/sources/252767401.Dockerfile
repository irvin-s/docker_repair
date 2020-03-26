FROM python:2  
RUN apt-get update  
  
RUN apt-get install -y mapserver-bin lighttpd fuse  
RUN apt-get clean all  
  
ADD http://gocfs.s3-website-us-east-1.amazonaws.com/gocfs /gocfs  
ADD wrapper.sh /wrapper.sh  
RUN chmod +x /gocfs /wrapper.sh  
  
COPY lighttpd.conf /lighttpd.conf  
  
VOLUME /cfg  
  
ENTRYPOINT ["/wrapper.sh"]  
CMD ["lighttpd", "-f", "/lighttpd.conf"]  

