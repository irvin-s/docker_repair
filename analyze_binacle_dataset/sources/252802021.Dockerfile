FROM python:2-alpine  
LABEL maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"  
  
COPY . /  
RUN apk add --no-cache --virtual .run-deps tzdata  
RUN pip install -r /app/requirements.txt  
  
ENTRYPOINT ["/docker-entrypoint.sh"]  
CMD ["crond", "-f"]  

