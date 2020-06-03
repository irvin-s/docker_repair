FROM nginx  
  
MAINTAINER Anthony O'Brien <asobrien@gmail.com>  
  
COPY sysconfig/ /  
  
EXPOSE 80 443  
  
CMD ["nginx"]

