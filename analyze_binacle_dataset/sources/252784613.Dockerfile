FROM alpine:3.3  
MAINTAINER Ike Devolder, ike.devolder@gmail.com  
  
ENV C_USER root  
  
COPY ./container /container  
ADD ./entrypoint.sh /entrypoint.sh  
  
RUN /container/install.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["sh"]  

