FROM ubuntu:14.04

ENV LC_CTYPE C.UTF-8

RUN apt-get update && apt-get install -y --force-yes \
    python-software-properties \
    git \
    curl

RUN apt-get install -y --force-yes software-properties-common  && \
    add-apt-repository ppa:fkrull/deadsnakes && \
    apt-get update && \
    apt-get -y --force-yes install python3.5-complete

RUN apt-get install -y build-essential python-dev

RUN python3.5 -m ensurepip && pip3.5 install gunicorn==19.4.0

WORKDIR /srv

ADD requirements.txt ./

RUN pip3.5 install --upgrade -r requirements.txt

ADD serve.py .coveragerc .dockerignore gunicorn.py ./

ADD data data
ADD config config
ADD deployer deployer
ADD tasks tasks
ADD tests tests

RUN chmod +x serve.py

CMD ["gunicorn", "--log-file=-", "-c", "/srv/gunicorn.py", "serve:app"]
