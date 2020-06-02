FROM nginx  
  
MAINTAINER Daniel Brooks <dbrooks@dabsquared.com>  
  
  
ENV URL symfony.dev  
ENV APPFILE app.php  
ENV UPSTREAM php  
  
ADD symfony.conf /etc/nginx/conf.d/symfony.conf  
RUN rm /etc/nginx/conf.d/default.conf  
  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod +x /entrypoint.sh  
ENTRYPOINT ["/entrypoint.sh"]  
  
EXPOSE 80 443  
HEALTHCHECK CMD curl --fail "http://127.0.0.1/1/anonymous/status" || exit 1  
  
CMD ["nginx", "-g", "daemon off;"]  
  

