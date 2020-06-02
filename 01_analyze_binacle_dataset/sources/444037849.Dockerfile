FROM xeor/base:7.1-5

MAINTAINER Lars Solberg <lars.solberg@gmail.com>
ENV REFRESHED_AT 2015-10-03

EXPOSE 8080

ENV TZ=Europe/Oslo

COPY supervisord.d/ /etc/supervisord.d/
COPY init/ /init/
COPY hooks/ /hooks/
RUN chmod +x /hooks/*

RUN pip install --upgrade pip && \
    yum install -y gcc python-devel git docker && \
    pip install buildbot buildbot-slave docker-compose

