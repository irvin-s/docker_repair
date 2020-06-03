# Cloud Foundry running stack
# version 0.4
FROM tchughesiv/cf-mini-release:v237
MAINTAINER Tommy Hughes <tchughesiv@gmail.com>

RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8

ENV HOME /root
ENV INSTALLER_BRANCH v237
ENV NISE_DOMAIN cf-mini.example
ENV NISE_PASSWORD c1oudc0w

ADD cf-env /root/cf_nise_installer/test_apps/cf-env/
ADD spring-music /root/cf_nise_installer/test_apps/spring-music/
ADD test_app /root/cf_nise_installer/test_apps/test_app/
ADD supervisord.conf /etc/supervisor/conf.d/
ADD run.sh /root/
ADD monit_daemon.sh /root/
ADD run_first.sh /root/
RUN chmod u+x /root/*.sh

WORKDIR /root/cf_nise_installer/test_apps
EXPOSE 80 443 4443
CMD /root/run_first.sh ; /root/run.sh & /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf