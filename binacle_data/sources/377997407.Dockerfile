FROM base
MAINTAINER Jacques Fuentes

RUN gem install dep --no-ri --no-rdoc
RUN mkdir -p /srv
RUN git clone https://github.com/jpfuentes2/example.git /srv/app
RUN cd /srv/app && dep install

ADD serf.json /etc/serf/config.json
ADD supervisord.conf /etc/supervisord/conf.d/supervisord.conf

WORKDIR /srv/app

EXPOSE 80 7946

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisord/conf.d/supervisord.conf"]
