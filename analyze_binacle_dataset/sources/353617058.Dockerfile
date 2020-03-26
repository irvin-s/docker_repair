FROM python:2.7
MAINTAINER Toni Pizà <tpiza@habitissimo.com>

RUN git clone https://github.com/mitro-co/emailer.git /srv/emailer

WORKDIR /srv/emailer
RUN ./build.sh

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["build/venv/bin/python", "emailer.py"]
