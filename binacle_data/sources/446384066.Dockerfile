FROM keyz182/ubuntu-lxde-novnc
MAINTAINER Kieran Evans <keyz182@gmail.com>

RUN apt-get update \
    && apt-get install -y --force-yes tzdata \
    && apt-get install -y --force-yes openjdk-7-jre openjdk-7-jre-headless tzdata-java\
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lib/apt/lists/*

ADD ../triana-app/dist /triana/
ADD triana.supervisor.conf /etc/supervisor/conf.d/
ADD 50-Triana-Copy.sh /etc/startup.aux/
RUN chmod +x /etc/startup.aux/50-Triana-Copy.sh

WORKDIR /
ENTRYPOINT ["/startup.sh"]
