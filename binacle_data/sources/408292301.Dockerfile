FROM registry.theopencloset.net/opencloset/perl:latest

RUN groupadd opencloset && useradd -g opencloset opencloset

RUN apt-get update && apt-get -y install cron

WORKDIR /tmp
COPY cpanfile cpanfile
RUN cpanm --notest \
    --mirror http://www.cpan.org \
    --mirror http://cpan.theopencloset.net \
    --installdeps .

# Everything up to cached.
WORKDIR /home/opencloset/service/staff.theopencloset.net
COPY . .
RUN chown -R opencloset:opencloset .
RUN mv app.conf.sample app.conf

# set env
ENV MOJO_HOME=/home/opencloset/service/staff.theopencloset.net
ENV MOJO_CONFIG=app.conf

# Install cronjob
RUN crontab -u opencloset .crontab

ENTRYPOINT ["./docker-entrypoint-cron.sh"]
