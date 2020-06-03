FROM fluent/fluentd:latest  
MAINTAINER Ted Chen <tedlchen@gmail.com>  
  
ENV TOKEN=""  
ENV NODE_HOSTNAME=""  
ENV LOGGLY_TAG=""  
RUN gem install fluent-plugin-loggly  
  
# Force back into root from fluentd's ubuntu  
USER root  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod 755 /entrypoint.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  
CMD [""]  

