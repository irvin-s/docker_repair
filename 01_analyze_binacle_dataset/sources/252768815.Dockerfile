FROM python:3.6.1-alpine3.6  
LABEL maintainer="portela.eng@gmail.com"  
  
ENV BASE_FOLDER /usr/src/app  
  
RUN mkdir ${BASE_FOLDER}  
  
COPY requirements.txt start.sh wait-for.sh ${BASE_FOLDER}/  
  
RUN apk update && \  
apk upgrade && \  
apk add --no-cache --virtual .build-dependencies \  
gcc=6.3.0-r4 \  
linux-headers=4.4.6-r2 \  
musl-dev=1.1.16-r14 \  
python3-dev=3.6.1-r3 && \  
apk add --no-cache postgresql-dev=9.6.6-r0 gettext=0.19.8.1-r1 && \  
addgroup -S django && \  
adduser -D -H -S django django && \  
chown -R django:django ${BASE_FOLDER} && \  
chmod +x ${BASE_FOLDER}/start.sh ${BASE_FOLDER}/wait-for.sh && \  
pip3 install --no-cache-dir -r ${BASE_FOLDER}/requirements.txt && \  
rm -rf /var/cache/apk/* && \  
apk del .build-dependencies  
  
WORKDIR ${BASE_FOLDER}  
  
CMD ./start.sh  
  
ENV DJANGO_PROJECT_NAME=gotalk1  
  
ADD . ${BASE_FOLDER}

