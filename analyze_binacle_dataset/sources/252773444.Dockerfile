FROM nginx  
  
RUN apt-get -qq update && apt-get -qq -y install curl  
  
RUN rm -f /etc/nginx/conf.d/*  
COPY default.conf /etc/nginx/conf.d/

