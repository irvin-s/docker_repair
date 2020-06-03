FROM golang:1.8.0
MAINTAINER Barak Bar Orion  <barak.bar@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get install -y git

RUN curl https://glide.sh/get | sh


RUN mkdir -p /golang/create-branch/src/github.com/barakb
WORKDIR /golang/create-branch/src/github.com/barakb

RUN git clone https://github.com/barakb/create-branch.git


WORKDIR /golang/create-branch/src/github.com/barakb/create-branch/keys
RUN /golang/create-branch/src/github.com/barakb/create-branch/keys/gen.sh


WORKDIR /golang/create-branch/src/github.com/barakb/create-branch
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.0/install.sh | bash
RUN echo  ~/.bashrc
RUN source ~/.bashrc && nvm install v8.1.2
RUN source ~/.bashrc && nvm use v8.1.2 && npm install webpack@2.6.1 -g && npm install && webpack


ENV GOPATH /golang/create-branch
RUN glide install



env PATH /golang/create-branch/src/github.com/barakb/create-branch:$PATH


WORKDIR /golang/create-branch
#COPY update.sh /golang/create-branch/
COPY serve.sh /golang/create-branch/

#RUN /golang/create-branch/update.sh

RUN go build -v -o bin/create-branch github.com/barakb/create-branch/main

WORKDIR /golang/create-branch/src/github.com/barakb/create-branch

RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf


#ENTRYPOINT ["/golang/create-branch/serve.sh"]
CMD ["/usr/bin/supervisord"]


EXPOSE 4430
