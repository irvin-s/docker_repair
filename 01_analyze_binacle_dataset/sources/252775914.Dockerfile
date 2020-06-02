FROM python:2.7.7  
MAINTAINER Harry Liang <blurrcat@gmail.com>  
  
RUN mkdir -p /usr/app  
WORKDIR /usr/app  
ADD requirements*.txt ./  
RUN pip install -r requirements.txt  
ADD . .  
RUN pip install -e .  
  
ENV WORKER_NUM 1  
ENV BIND 0.0.0.0:8000  
ENV DEBOT_DEBUG False  
ENV DEBOT_SLACK_TOKEN stupid_token  
EXPOSE 8000  
CMD gunicorn -k gevent --access-logfile - -w $WORKER_NUM -b $BIND \  
"debot.app:create_app()"  

