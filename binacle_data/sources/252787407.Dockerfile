FROM php:5.6-cli  
MAINTAINER George Tavantzopoulos <g.tavantzopoulos@gmail.com>  
RUN mkdir /src  
EXPOSE 80  
# Install modules  
WORKDIR /src  
ENTRYPOINT ["php", "-S", "0.0.0.0:80"]  
CMD ["-t","/src"]  

