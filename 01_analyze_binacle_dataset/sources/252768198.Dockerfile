FROM alpine  
  
RUN apk add --no-cache bind bind-tools  
  
EXPOSE 53 53/udp  
VOLUME /etc/bind  
WORKDIR /etc/bind  
  
ADD ./start.sh /start.sh  
RUN chmod +x /start.sh  
CMD /start.sh

