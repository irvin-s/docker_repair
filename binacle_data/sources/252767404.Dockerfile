FROM node:0.12  
MAINTAINER Alexander Lukichev  
EXPOSE 5000  
VOLUME /app  
ADD runnode.sh /  
  
WORKDIR /app  
  
CMD ["/runnode.sh"]  
  

