FROM danlucas/laravel-docker-base:0.1.0  
  
MAINTAINER "Daniel Lucas" <daniel.chris.lucas@gmail.com>  
  
USER root  
RUN mkdir -p /data  
USER developer  
VOLUME ["/data"]  
CMD ["true"]

