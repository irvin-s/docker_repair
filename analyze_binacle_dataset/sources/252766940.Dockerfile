FROM ubuntu:utopic  
MAINTAINER Albert Dixon <albert@timelinelabs.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update -qq  
RUN apt-get install --no-install-recommends -y --force-yes \  
ruby gettext-base curl wget ca-certificates \  
avahi-daemon avahi-utils supervisor &&\  
apt-get autoclean -y &&\  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN gem install --minimal-deps --no-document --clear-sources clockwork &&\  
gem cleanup  
  
ADD configs/* /etc/supervisor/conf.d/  
ADD scripts/clock.rb /root/  
ADD scripts/docker-start /usr/local/bin/  
ADD scripts/plexupdate.sh /usr/local/bin/  
ADD scripts/start_pms /usr/local/bin/  
RUN chmod a+rx /usr/local/bin/* &&\  
mkdir -p /plexupdate /plexmediaserver &&\  
touch /first_run  
  
ENTRYPOINT ["docker-start"]  
VOLUME ["/plexmediaserver"]  
EXPOSE 32400 1900 5353 32410 32412 32413 32414 32469  
ENV DOWNLOADDIR /plexupdate  
ENV FORCE no  
ENV PUBLIC no  
ENV AUTOINSTALL yes  
ENV RELEASE 64-bit  
ENV URL_LOGIN https://plex.tv/users/sign_in  
ENV URL_DOWNLOAD https://plex.tv/downloads?channel=plexpass  
ENV URL_DOWNLOAD_PUBLIC https://plex.tv/downloads  
ENV UPDATE_TIME 3:00  
ENV PLEX_MEDIA_SERVER_HOME /usr/lib/plexmediaserver  
ENV PLEX_MEDIA_SERVER_USER root  
ENV PLEX_MEDIA_SERVER_APPLICATION_SUPPORT_DIR /plexmediaserver  
ENV PLEX_MEDIA_SERVER_TMPDIR /tmp  
ENV PLEX_MEDIA_SERVER_MAX_STACK_SIZE 4000  
ENV PLEX_MEDIA_SERVER_MAX_PLUGIN_PROCS 6

