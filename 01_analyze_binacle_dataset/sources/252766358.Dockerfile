FROM debian:stretch-slim  
MAINTAINER Abner G Jacobsen - http://daspanel.com <admin@daspanel.com>  
  
# A little bit of metadata management.  
# See http://label-schema.org/  
LABEL org.label-schema.schema-version="1.0" \  
org.label-schema.build-date=$BUILD_DATE \  
org.label-schema.version=$VERSION \  
org.label-schema.vcs-url=$VCS_URL \  
org.label-schema.vcs-ref=$VCS_REF \  
org.label-schema.name="abnerjacobsen/dizendo-dev" \  
org.label-schema.description="Dizendo.ai dev"  
# Debian and systemd  
ENV container docker  
ENV DEBIAN_FRONTEND noninteractive  
ENV TERM=xterm  
ENV init /lib/systemd/systemd  
ENV SHELL=/bin/bash  
# Set the locale  
ENV TZ="UTC"  
ENV LC_ALL="C.UTF-8"  
ENV LANG="C.UTF-8"  
ENV LANGUAGE="C.UTF-8"  
ENV LC_CTYPE="C.UTF-8"  
# add contrib, non-free and backports repositories  
ADD debian/sources.list /etc/apt/sources.list  
  
# pin stable repositories  
ADD debian/preferences /etc/apt/preferences  
  
RUN apt-get -y update \  
&& apt-get install -y ca-certificates apt-utils apt-transport-https \  
&& apt-get -y upgrade \  
&& apt-get clean \  
&& apt-get install -y \  
systemd \  
locales \  
tzdata \  
gnupg \  
net-tools \  
bash \  
curl \  
wget \  
unzip \  
patch \  
nano \  
procps \  
lsof \  
dos2unix \  
tree \  
pwgen \  
git \  
bzip2 \  
python3 \  
python3-all-dev \  
python3-pip \  
sudo \  
findutils \  
tar \  
  
&& apt-get install -y --no-install-recommends \  
portaudio19-dev \  
swig \  
libpulse-dev \  
alsa-utils \  
  
&& locale-gen C.UTF-8 \  
&& ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime \  
  
# Python pip  
&& curl "https://bootstrap.pypa.io/get-pip.py" | python3 \  
&& pip3 install --no-cache-dir --upgrade pip setuptools \  
&& rm -r /root/.cache \  
  
# Install pipenv  
&& pip3 install pipenv \  
  
&& groupadd -g 1000 app \  
&& useradd -u 1000 -d /home/app -s /bin/false -g app app \  
  
# Cleanup  
&& apt-get clean \  
&& rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/* \  
  
# Systemd  
&& rm -f /lib/systemd/system/multi-user.target.wants/* \  
/etc/systemd/system/*.wants/* \  
/lib/systemd/system/local-fs.target.wants/* \  
/lib/systemd/system/sockets.target.wants/*udev* \  
/lib/systemd/system/sockets.target.wants/*initctl* \  
/lib/systemd/system/sysinit.target.wants/systemd-tmpfiles-setup* \  
/lib/systemd/system/systemd-update-utmp* \  
&& systemctl set-default multi-user.target  
  
  
# Creating data directory  
RUN mkdir /data  
RUN chown -R app.app /data/  
  
# Creating working directory  
WORKDIR /app  
RUN chown -R app.app /app/  
  
ENV PYTHONUNBUFFERED 1  
EXPOSE 8080  
  
VOLUME [ "/sys/fs/cgroup" ]  
ENTRYPOINT ["/lib/systemd/systemd"]  
  

