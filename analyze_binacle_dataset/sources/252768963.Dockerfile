FROM node:6.9.2-alpine  
  
COPY ./app/ /var/www/html/web/  
  
RUN cd /var/www/html/web/ && npm install && \  
apk update && apk upgrade && \  
apk add git bash && \  
git clone https://github.com/vishnubob/wait-for-it.git /root/wfi  
  
COPY ./src/wait /root/  
RUN apk add --update supervisor  
RUN mkdir /etc/supervisor.d  
COPY ./src/supervisor/conf/listener.ini /etc/supervisor.d/notifications.ini  
  
CMD /bin/sh /root/start.sh

