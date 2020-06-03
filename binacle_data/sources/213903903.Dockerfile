FROM python:2.7
MAINTAINER ADI <hello@adicu.com>

RUN apt-get update && apt-get upgrade --yes
RUN apt-get install --yes ruby ruby-dev
RUN gem install sass
ENV GOOGLE_APPLICATION_CREDENTIALS=./config/adi-secrets.json


COPY ./config/requirements.txt /app/requirements.txt
RUN pip install -r /app/requirements.txt

ADD ./ /deploy
WORKDIR /deploy

EXPOSE 8181
CMD /bin/bash -c "source /deploy/config/secrets.prod && \
       gunicorn run:app -b 0.0.0.0:8181"
