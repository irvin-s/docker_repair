FROM debian:8.5  
MAINTAINER David Bourasseau <dbourasseau@viotech.net>  
  
  
RUN apt-get -y update && apt-get -y install rsyslog curl  
  
ADD start-cron.sh /usr/bin/start-cron.sh  
RUN chmod +x /usr/bin/start-cron.sh  
  
ADD tnova_send_metric /usr/local/bin/tnova_send_metric  
RUN chmod +x /usr/local/bin/tnova_send_metric  
  
ENV RABBITMQ CDN-LB  
ENV QUEUE soft  
ENV PORTRABBITMQ 15672  
ENV METRICNAME worker  
  
ADD worker_metric /usr/local/bin/worker_metric  
RUN chmod +x /usr/local/bin/worker_metric  
  
# Run the command on container startup  
CMD /usr/bin/start-cron.sh  

