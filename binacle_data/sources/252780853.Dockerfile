FROM python:3.5-alpine  
MAINTAINER "WhiteCode team"  
RUN apk update \  
&& apk upgrade \  
&& apk add build-base jpeg-dev zlib-dev  
  
ENV PROJDIR=/var/local/libracours  
  
RUN mkdir -p $PROJDIR  
COPY . $PROJDIR  
WORKDIR $PROJDIR  
  
RUN pip install -r requirements.txt  
  
ENTRYPOINT ["./docker-setup.sh"]  

