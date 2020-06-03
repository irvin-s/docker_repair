FROM stackbrew/ubuntu

ENV DEBIAN_FRONTEND noninteractive

RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache
RUN echo "Europe/Paris" > /etc/timezone; dpkg-reconfigure tzdata

RUN apt-get update -y
