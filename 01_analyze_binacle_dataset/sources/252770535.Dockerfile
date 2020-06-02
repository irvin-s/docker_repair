# Run nginx with a markdown handler for *.md files  
#  
FROM nginx:latest  
MAINTAINER Assaf <assaf@localhost>  
  
RUN apt-get update && apt-get install -y fcgiwrap  
  
COPY nginx.conf /etc/nginx/nginx.conf  
COPY default.conf /etc/nginx/conf.d/default.conf  
  
RUN mkdir /usr/lib/cgi-bin  
COPY markdownjs.sh /usr/lib/cgi-bin/markdownjs.sh  
  
RUN sed -i 's/txt;/txt yml;/' /etc/nginx/mime.types  
  
COPY init.sh /init.sh  
CMD [ "/init.sh" ]  

