# BUILDING
# docker build -t stuckless/sagetv-server-java8-stvdev:latest .

FROM stuckless/sagetv-server-java8:latest

MAINTAINER Sean Stuckless <sean.stuckless@gmail.com>

RUN set -x

#ENV DISPLAY
#ENV QT_X11_NO_MITSHM 1
VOLUME ["/tmp/.X11-unix"]

ADD init.d/86-sagetv-dev /etc/my_init.d/86-sagetv-dev
RUN chmod 755 /etc/my_init.d/86-sagetv-dev

RUN set -x \
  && apt-get update \
  && apt-get install -y moreutils libxrender1 xvfb 	libxtst6 xauth libxi6

