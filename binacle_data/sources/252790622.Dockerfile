FROM nginx  
  
MAINTAINER Carl Skeide "carl@skeide.se"  
COPY ./nginx.conf /etc/nginx/nginx.conf  
  
RUN mkdir -p /srv/www /srv/static /srv/media  
  
COPY ./docker-entrypoint.sh /docker-entrypoint.sh  
  
WORKDIR /  
ENTRYPOINT ["/docker-entrypoint.sh" ]  
CMD [ "nginx" ]  

