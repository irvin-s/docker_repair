# openjdk:8u131-jre-alpine based on alpine:3.4  
FROM openjdk:8u131-jre-alpine  
  
##############################  
# install bash  
##############################  
RUN apk add --no-cache --update bash  
  
##############################  
# install supervisord  
##############################  
ENV PYTHON_VERSION=2.7.13-r1  
ENV PY_PIP_VERSION=9.0.1-r1  
ENV SUPERVISOR_VERSION=3.3.1  
RUN \  
apk update && \  
apk add -u python=$PYTHON_VERSION py-pip=$PY_PIP_VERSION && \  
apk add tzdata && \  
cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \  
apk del tzdata && \  
pip install supervisor==$SUPERVISOR_VERSION  
  
WORKDIR /  
  

