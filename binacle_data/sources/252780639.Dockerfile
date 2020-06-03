FROM phusion/baseimage:0.9.17  
MAINTAINER David Coppit <david@coppit.org>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
# Speed up APT  
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup \  
&& echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache  
  
# See https://help.ubuntu.com/community/DansGuardian  
RUN set -x \  
&& apt-get update -q \  
&& apt-get install -qy dansguardian squid  
  
RUN set -x \  
&& apt-get autoremove -y \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN sed -i "/^UNCONFIGURED/ d" /etc/dansguardian/dansguardian.conf  
RUN echo 'always_direct allow all' >> /etc/squid3/squid.conf  
  
# Create dir to keep things tidy  
RUN mkdir /files  
  
COPY run.sh /files/run.sh  
  
EXPOSE 8080/tcp  
  
ENTRYPOINT ["/files/run.sh"]  

