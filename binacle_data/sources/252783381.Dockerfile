FROM deanatruntriz/debian-web:wheezy  
  
MAINTAINER "Dean Mraz" <deanm@runtriz.com>  
  
RUN apt-get install -y supervisor  
  
RUN mkdir -p /laravel  
  
ENV WORKER_DIR=/laravel  
ENV WORKER_LOGFILE=/laravel/app/storage/logs/worker.log  
  
COPY worker.conf /etc/supervisor/conf.d/worker.conf  
  
ADD run.sh /run.sh  
RUN chmod -v +x /run.sh  
CMD ["/run.sh"]  

