FROM fluent/fluentd:latest  
MAINTAINER Li-Te Chen <datacoda@gmail.com>  
  
ENV TOKEN=""  
ENV NODE_HOSTNAME=""  
ENV LOGGLY_TAG="docker,container"  
RUN gem install fluent-plugin-loggly  
  
# Force back into root from fluentd's ubuntu  
USER root  
COPY docker-entrypoint.sh /entrypoint.sh  
RUN chmod 755 /entrypoint.sh  
  
USER ubuntu  
ENTRYPOINT ["/entrypoint.sh"]  
CMD [""]

