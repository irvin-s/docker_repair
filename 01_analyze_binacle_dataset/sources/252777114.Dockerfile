FROM rabbitmq:3.6.9  
  
ENV RABBITMQ_USE_LONGNAME=true \  
AUTOCLUSTER_LOG_LEVEL=debug \  
AUTOCLUSTER_CLEANUP=true \  
CLEANUP_INTERVAL=60 \  
CLEANUP_WARN_ONLY=false \  
AUTOCLUSTER_TYPE=k8s \  
LANG=en_US.UTF-8  
  
COPY plugins/*.ez /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.9/plugins/  
  
RUN chown -R rabbitmq /usr/lib/rabbitmq/lib/rabbitmq_server-3.6.9/plugins/  
  
RUN rabbitmq-plugins enable --offline autocluster  
  
RUN rabbitmq-plugins enable rabbitmq_management  

