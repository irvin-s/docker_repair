FROM node:0.12  
MAINTAINER Alexander Lukichev  
EXPOSE 5000  
RUN apt-get update  
RUN apt-get install -y fuse  
RUN apt-get clean all  
  
ADD http://gocfs.s3-website-us-east-1.amazonaws.com/gocfs /gocfs  
ADD wrapper.sh /wrapper.sh  
RUN chmod +x /gocfs /wrapper.sh  
  
VOLUME /cfg  
  
VOLUME /app  
  
ADD runnode.sh /  
  
WORKDIR /app  
  
ENTRYPOINT ["/wrapper.sh"]  
  
CMD ["/runnode.sh" ]  
  

