FROM barkingiguana/rvm  
  
MAINTAINER Craig R Webster <craig@barkingiguana.com>  
  
ADD ./start-app.sh /usr/sbin/start-app  
RUN chmod +x /usr/sbin/start-app  
  
RUN mkdir -p /u/app  
WORKDIR /u/app  
  
ENV RACK_ENV production  
  
EXPOSE 3000  
CMD ["/usr/sbin/start-app"]  

