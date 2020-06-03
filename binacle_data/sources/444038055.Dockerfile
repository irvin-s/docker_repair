FROM xeor/base-centos-daemon

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-02-26

ENV TERM xterm-256color

RUN yum install -y git tar gcc-c++ nodejs make emacs-nox tmux
RUN curl https://www.npmjs.com/install.sh | clean=no sh
RUN git clone https://github.com/nathanleclaire/wetty.git && \
    cd wetty && \
    npm install

# We are symlinking /bin/bash to /shell if there is no /shell mounted. If there is a /shell
# we will make it executable, so it can act as a standalone shell
RUN sed 's@/bin/login@/shell@' -i /wetty/app.js

COPY init/ /init/
COPY supervisord.d/ /etc/supervisord.d/

EXPOSE 3000

