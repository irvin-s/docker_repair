FROM ubuntu:14.04


RUN apt-get update -y
RUN apt-get install -y python-pip python-dev

ENV CELERY_BROKER_URL redis://redis:6379/0
ENV CELERY_RESULT_BACKEND redis://redis:6379/0
ENV C_FORCE_ROOT true


# copy source code
COPY . /flask-celery
WORKDIR /flask-celery

# install requirements
RUN pip install -r requirements.txt


# run the worker
#ENTRYPOINT ['celery']
#CMD ['-A','tasks', 'worker','--loglevel=info']
ENTRYPOINT celery -A tasks worker --loglevel=info
