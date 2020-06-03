FROM phusion/baseimage:latest

MAINTAINER George Vagenas - gvagenas@telestax.com
MAINTAINER Jean Deruelle - jean.deruelle@telestax.com
MAINTAINER Lefteris Banos - liblefty@telestax.com

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

ENV DEBIAN_FRONTEND noninteractive
ENV JAVA_HOME /usr/lib/jvm/java-1.7.0-openjdk-amd64

RUN locale-gen en_US en_US.UTF-8 && dpkg-reconfigure locales

RUN add-apt-repository -y ppa:openjdk-r/ppa \
  && apt-cache search mysql-client-core \
  && apt-get update \
  && apt-get install -y \
    screen \
    wget \
    ipcalc \
    bsdtar \
    openjdk-7-jdk \
    mysql-client-core-5.7 \
    openssl \
    unzip \
    nfs-common \
    tcpdump \
    dnsutils \
    net-tools \
    xmlstarlet \
  && apt-get autoremove \
  && apt-get autoclean \
  && rm -rf /var/lib/apt/lists/*

# download restcomm
ENV install_dir /opt/Restcomm-JBoss-AS7
RUN wget -qO- https://app.box.com/shared/static/4cu7p8w0ru8cdvw1o3ranjwras9w102x.txt -O released-versions.txt \
  && awk '/Restcomm-Connect-/ {a=$0} END{print a}' released-versions.txt | awk -F'::' '{print $3}' > /tmp/release_url \
  && wget -qc `cat /tmp/release_url` -O Restcomm-JBoss-AS7.zip \
  && unzip Restcomm-JBoss-AS7.zip -d /opt/ \
  && mv /opt/Restcomm-JBoss-AS7-*/ ${install_dir} \
  && rm Restcomm-JBoss-AS7.zip

RUN mkdir -p /opt/embed/

ADD ./ca-startcom.der /opt/Restcomm-JBoss-AS7/ca-startcom.der
ADD ./cron_files/tcpdump_crontab /etc/cron.d/restcommtcpdump-cron
ADD ./cron_files/core_crontab /etc/cron.d/restcommcore-cron
ADD ./cron_files/mediaserver_crontab /etc/cron.d/restcommmediaserver-cron
ADD ./scripts/dockercleanup.sh /opt/embed/dockercleanup.sh
ADD ./scripts/docker_do.sh   /opt/embed/restcomm_docker.sh

RUN mkdir -p /etc/my_init.d

ADD ./scripts/restcomm_autoconf.sh /etc/my_init.d/restcomm1.sh
ADD ./scripts/restcomm_conf.sh /etc/my_init.d/restcomm2.sh
ADD ./scripts/restcomm_sslconf.sh /etc/my_init.d/restcomm3.sh
ADD ./scripts/restcomm_extconf.sh /etc/my_init.d/restcomm4.sh
ADD ./scripts/restcomm_toolsconf.sh /etc/my_init.d/restcomm5.sh
ADD ./scripts/restcomm-runlevels.sh /etc/my_init.d/restcomm6.sh
ADD ./scripts/restcomm_tag.sh /etc/my_init.d/restcomm7.sh

ADD ./scripts/restcomm_service.sh /tmp/restcomm_service.sh
ADD ./scripts/rms_service.sh /tmp/rms_service.sh
ADD ./scripts/start-mediaserver.sh /tmp/start-mediaserver.sh
ADD ./scripts/start-restcomm.sh /tmp/start-restcomm.sh
RUN chmod +x /etc/my_init.d/restcomm*.sh

EXPOSE 5080/udp  5080/tcp 5081/tcp 5082/tcp 5083/tcp 8080/tcp 8443/tcp 5060/udp 5060/tcp 5061/tcp 5062/tcp 5063/tcp 80/tcp 443/tcp 9990/tcp 65000-65535/udp





