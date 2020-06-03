FROM mikz/base:trusty
MAINTAINER Michal Cichra <michal.cichra@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

RUN adduser transmission --home /mnt/storage --disabled-password -q \
 && mkdir /var/run/sshd

RUN apt-add-repository -y ppa:transmissionbt/ppa \
 && apt-install supervisor transmission-cli transmission-daemon openssh-server \
		ruby ruby-dev cron build-essential libcurl3 zlib1g-dev \
 && gem install prss --version=0.1.1

ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
ADD sshd_config /etc/ssh/sshd_config

WORKDIR /mnt/storage/

CMD ["/usr/bin/supervisord"]

EXPOSE 22 9091 51413
