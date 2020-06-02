#  
# Base Webdriver Dockerfile  
#  
  
FROM debian:stretch  
  
MAINTAINER Sebastian Tschan <mail@blueimp.net>  
  
# Install the base requirements to run and debug webdriver implementations:  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get dist-upgrade -y \  
&& apt-get install --no-install-recommends --no-install-suggests -y \  
xvfb \  
xauth \  
ca-certificates \  
x11vnc \  
fluxbox \  
xvt \  
curl \  
# Remove obsolete files:  
&& apt-get clean \  
&& rm -rf \  
/tmp/* \  
/usr/share/doc/* \  
/var/cache/* \  
/var/lib/apt/lists/* \  
/var/tmp/*  
  
# Add tini, a tiny but valid init system for containers:  
RUN apt-get update \  
&& apt-get install --no-install-recommends --no-install-suggests -y \  
gpg \  
dirmngr \  
&& export TINI_VERSION=v0.14.0 && curl -sL \  
https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini \  
> /sbin/tini && chmod +x /sbin/tini \  
&& curl -sL \  
https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini.asc \  
> /sbin/tini.asc \  
&& gpg --keyserver pool.sks-keyservers.net --recv-keys \  
595E85A6B1B4779EA4DAAEC70B588DFF0527A9B7 \  
&& gpg --verify /sbin/tini.asc \  
&& rm -rf /root/.gnupg \  
&& rm /sbin/tini.asc \  
&& apt-get autoremove --purge -y \  
gpg \  
dirmngr  
  
# Patch xvfb-run to support TCP port listening (disabled by default in X:  
RUN sed -i 's/LISTENTCP=""/LISTENTCP="-listen tcp"/' /usr/bin/xvfb-run  
  
# Add webdriver user+group as a workaround for  
# https://github.com/boot2docker/boot2docker/issues/581  
RUN useradd -u 1000 -m -U webdriver  
  
WORKDIR /home/webdriver  
  
COPY entrypoint.sh /usr/local/bin/entrypoint  
COPY vnc-start.sh /usr/local/bin/vnc-start  
  
# Configure Xvfb via environment variables:  
ENV SCREEN_WIDTH 1440  
ENV SCREEN_HEIGHT 900  
ENV SCREEN_DEPTH 24  
ENV DISPLAY :60  
  
ENTRYPOINT ["entrypoint"]  
  
# Expose the default webdriver port:  
EXPOSE 4444  

