FROM nginx:alpine  
MAINTAINER danieladams456@gmail.com  
COPY init.sh /root/init.sh  
RUN chmod +x /root/init.sh  
CMD /root/init.sh  

