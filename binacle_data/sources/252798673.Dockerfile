# Reference:  
# http://perl-howto.de/2008/06/making-your-own-cpanmini.html  
FROM ubuntu:14.04  
MAINTAINER Michael Mayr <michael@dermitch.de>  
  
ENV DEBIAN_FRONTEND noninteractive  
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup; \  
echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache; \  
apt-get update; apt-get upgrade -y;  
  
RUN apt-get install -y libcpan-mini-perl  
RUN mkdir /cpan  
  
ADD boot.sh /boot.sh  
  
VOLUME "/cpan"  
  
CMD ["/boot.sh"]  

