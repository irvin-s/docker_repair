FROM oneops/centos7

ENV OO_HOME /home/oneops
ENV INDUCTOR_HOME /opt/oneops
ENV GITHUB_URL https://github.com/oneops
VOLUME ${OO_HOME}
VOLUME ${INDUCTOR_HOME}/inductor

WORKDIR /opt
COPY inductor.ini /etc/supervisord.d/inductor.ini
COPY inductor.sh inductor.sh
WORKDIR ${INDUCTOR_HOME}/inductor
