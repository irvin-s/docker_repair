FROM python:3.6

ADD requirements.txt /app/requirements.txt
RUN sed '/^uWSGI/ d' < /app/requirements.txt > /app/requirements_filtered.txt
WORKDIR /app/
RUN pip install -r requirements_filtered.txt
RUN pip install urlparser secretcli

RUN apt-get update \
 && apt-get install -y -f netcat \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ENV SETTINGS /app/settings.yaml

RUN useradd -ms /bin/bash apprunner
USER apprunner

RUN mkdir -p /home/apprunner/.aws
RUN touch /home/apprunner/.aws/credentials
RUN touch /home/apprunner/.aws/config
RUN chown -R apprunner:apprunner /home/apprunner/.aws

ADD ./docker/worker/start_worker.sh /home/apprunner/start_worker.sh
ADD ./app/ /app/app

ENTRYPOINT /home/apprunner/start_worker.sh
