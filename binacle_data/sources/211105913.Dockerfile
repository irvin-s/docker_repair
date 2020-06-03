FROM python:3
MAINTAINER Dibyo Majumdar <dibyo.majumdar@gmail.com>


RUN mkdir -p ~/.ssh \
  && ssh-keyscan -t rsa github.com >> ~/.ssh/known_hosts
RUN git config --global user.name "Berkeley Scheduler Bot" \
  && git config --global user.email "berkeley-scheduler@berkeley.edu"

RUN wget -qO- https://deb.nodesource.com/setup_6.x | bash - \
  && apt-get install -y nodejs

RUN git clone https://github.com/mDibyo/berkeley-scheduler
ENV APP_ROOT /berkeley-scheduler

RUN cd ${APP_ROOT} \
  && npm install --production
