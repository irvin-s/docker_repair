FROM gavinmroy/alpine-rabbitmq-autocluster:3.6.2-0.6.1  
  
USER 0  
RUN apk add curl  
USER rabbitmq  
  
COPY docker-entrypoint.sh /  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["/usr/lib/rabbitmq/sbin/rabbitmq-server"]  

