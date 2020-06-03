FROM python:3.6.0-alpine  
  
MAINTAINER Ajay Divakaran <ajay.divakaran86@hotmail.com>  
  
ENV APP_HOME=/app  
ENV APP_LOGS=/var/log/gunicorn  
ENV CRON_LOG=/var/log/cron  
  
RUN mkdir $APP_HOME $APP_LOGS $CRON_LOG  
WORKDIR $APP_HOME  
  
COPY . $APP_HOME  
  
# Install dependencies  
RUN apk update && apk --no-cache add build-base postgresql-dev  
RUN pip install -r requirements.txt  
  
RUN /usr/bin/crontab /app/crontab.txt  
EXPOSE 8000  
ENTRYPOINT ["/app/docker-entrypoint.sh"]  
  

