FROM composer as composer-step  
  
COPY ./src /app  
RUN composer install  
  
FROM php:7.1-alpine  
  
WORKDIR /app  
  
RUN apk add --update \  
git \  
python \  
py-pip \  
bash  
RUN pip install awscli --upgrade --user  
  
ENV DRONE_BUILD_EVENT push  
ENV CACHE_DRIVER array  
ENV SESSION_DRIVER array  
ENV QUEUE_DRIVER array  
ENV AWS_ACCESS_KEY_ID _blank_  
ENV AWS_SECRET_ACCESS_KEY _blank_  
ENV DOCKER_API_URL https://index.docker.io  
ENV AWS_REGION eu-west-2  
COPY \--from=composer-step /app /drone-pipeline-init  
ADD entrypoint.sh /bin/entrypoint.sh  
RUN chmod +x /bin/entrypoint.sh  
  
ENTRYPOINT /bin/entrypoint.sh

