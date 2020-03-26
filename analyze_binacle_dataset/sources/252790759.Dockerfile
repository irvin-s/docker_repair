FROM alpine  
MAINTAINER Casey Fulton <casey@caseyfulton.com>  
RUN apk add --no-cache --no-progress transmission-daemon sudo  
COPY start.sh /start.sh  
CMD ["/start.sh"]  

