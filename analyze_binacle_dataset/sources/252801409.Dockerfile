FROM eaglechen/docker-spark:base  
MAINTAINER Eagle Chen <chygr1234@gmail.com>  
  
COPY master.sh /master.sh  
ENTRYPOINT ["/master.sh"]  
  
EXPOSE 7077 8080  

