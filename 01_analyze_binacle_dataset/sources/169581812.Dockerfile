FROM ubuntu:14.04
MAINTAINER Rui Gonçalves <ruippeixotog@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get -y update
RUN apt-get install -y wget

ADD install-macspoof.sh /install-macspoof.sh
RUN /install-macspoof.sh

RUN echo "deb http://dl.google.com/linux/musicmanager/deb/ stable main" >> /etc/apt/sources.list.d/google-musicmanager.list
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -

RUN apt-get -y update
RUN apt-get install -y google-musicmanager-beta xvfb x11vnc supervisor

RUN mkdir /music
VOLUME /music

RUN mkdir -p /appdata /.config /root/.config
RUN ln -s /appdata /.config/google-musicmanager
RUN ln -s /appdata /root/.config/google-musicmanager
VOLUME /appdata

EXPOSE 5900

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD google-musicmanager.sh /google-musicmanager.sh

CMD ["/usr/bin/supervisord"]
