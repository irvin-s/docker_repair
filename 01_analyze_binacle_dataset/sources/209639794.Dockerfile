## -*- docker-image-name: "clma/docker-turtl" -*-
#
# turtl.it unofficial API Dockerfile
#

FROM nfnty/arch-mini:latest
MAINTAINER clma <claus@crate.io>

RUN mkdir /quicklisp /data

RUN pacman -Sy sbcl git libuv gcc --noconfirm
RUN curl -O https://beta.quicklisp.org/quicklisp.lisp && sbcl --load quicklisp.lisp <<< $'(quicklisp-quickstart:install :path "/quicklisp/")'

RUN git clone https://github.com/turtl/api.git --depth 1 /turtl

RUN echo $'(load "/quicklisp/setup.lisp")\n(push #p"/turtl/" asdf:*central-registry*)\n(load "start")' > /turtl/cmd.args
RUN echo '/usr/bin/sbcl < /turtl/cmd.args' > /turtl/run.sh

VOLUME ["/turtl/config", "/data"]

# auto link default config (?)
#ADD /turtl/config/config.default.lisp /turtl/config/config.lisp


WORKDIR /turtl

EXPOSE 8181

CMD ["/usr/bin/bash" , "/turtl/run.sh"]
