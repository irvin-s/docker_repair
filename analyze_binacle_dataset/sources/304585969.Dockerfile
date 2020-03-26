FROM ubuntu:16.04

MAINTAINER Dominik Schulz <dominik.schulz@gauner.org>

RUN apt-get update --yes && apt-get install --yes --force-yes --no-install-recommends \
  build-essential \
  cpanminus \
  eatmydata \
  libconfig-std-perl \
  libmoose-perl \
  libnamespace-autoclean-perl \
  libmoosex-app-cmd-perl \
  libtest-pod-perl \
  make \
  perl \
  perltidy \
  rsync \
  openssh-client \
  && rm -rf /var/lib/apt/lists/*

RUN cpanm --force \
  Config::Yak \
  Job::Manager \
  Log::Tree \
  Schedule::Cron \
  Sys::Bprsync \
  Sys::FS \
  Sys::RotateBackup \
  Sys::Run \
  Sys::Hostname::FQDN \
  Zabbix::Sender

ADD . /srv/revobackup
WORKDIR /srv/revobackup
ENV PERL5LIB /srv/revobackup/lib

RUN chmod +x /srv/revobackup/bin/cron.pl
RUN chmod +x /srv/revobackup/bin/revobackup.pl
RUN mkdir -p /etc/revobackup/
RUN mkdir -p /srv/backup/revobackup/
RUN mkdir -p /root/.ssh && chmod 0700 /root/.ssh
RUN cp /srv/revobackup/conf/default.xcl /etc/revobackup/default.xcl
RUN cp /srv/revobackup/conf/revobackup.conf.dist /etc/revobackup/revobackup.conf
RUN cp /srv/revobackup/conf/schedule.cron /etc/revobackup/schedule.cron
ENV CRONTAB /etc/revobackup/schedule.cron
ENV LOG_TREE_STDOUT 1

CMD /srv/revobackup/bin/cron.pl
