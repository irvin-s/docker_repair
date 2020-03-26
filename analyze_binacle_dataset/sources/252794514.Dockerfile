FROM docker:latest  
  
# set compose env files  
env COMPOSE_PROJECT_NAME=catalog-app  
env COMPOSE_FILE=/docker-compose.yml  
  
COPY crontab /etc/crontabs/root  
  
# install docker-compose  
RUN apk update && \  
apk add py-pip && \  
pip install docker-compose  
  
CMD ["crond", "-f", "-d", "8"]  

