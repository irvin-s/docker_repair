FROM 1and1internet/ubuntu-16-nginx-passenger-python-3:latest  
MAINTAINER brian.wojtczak@1and1.co.uk  
ARG BAKED=True  
ARG DJANGO_VER=1.9.11  
ARG DJANGO_CELERY_VER=3.1.17  
ARG CELERY_VER=3.1.24  
ENV \  
DJANGO_VER=${DJANGO_VER} \  
DJANGO_CELERY_VER=${DJANGO_CELERY_VER} \  
CELERY_VER=${CELERY_VER} \  
PASSENGER_APP_ENV=production \  
CELERY_BROKER_URL=amqp://guest:guest@rabbitmq:5672// \  
CELERY_BROKER_API=http://guest:guest@rabbitmq:15672/api/ \  
SECRET_KEY=insecure \  
DJANGO_LOG_LEVEL=INFO \  
CELERY_CONCURRENCY=AUTO  
COPY files /  
RUN application-bootstrap  
WORKDIR /var/www/  
CMD ["application-all"]  

