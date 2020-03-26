FROM alpine:3.2  
MAINTAINER Leonid Makarov <https://github.com/lmakarov>  
  
ENV DOCKER_COMPOSE_VERSION 1.3.0  
RUN apk --update add py-pip py-yaml &&\  
pip install -U docker-compose==${DOCKER_COMPOSE_VERSION} &&\  
rm -rf `find / -regex '.*\\.py[co]' -or -name apk`  
  
ENTRYPOINT ["docker-compose"]  
CMD ["--version"]  

