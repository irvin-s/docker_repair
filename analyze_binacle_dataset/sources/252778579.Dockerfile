FROM behance/docker-nginx:8.1-alpine  
  
ENV LIFESPAN=60 \  
RANDOM_MIN=0 \  
RANDOM_MAX=0 \  
S6_KILL_FINISH_MAXTIME=10 \  
S6_KILL_GRACETIME=10 \  
SERVER_APP_NAME=suicide \  
SERVER_LOG_MINIMAL=1 \  
EXIT_CODE=0  
  
# Overlay the root filesystem from this repo  
COPY ./container /  
  
CMD /etc/services.d/suicide/run  

