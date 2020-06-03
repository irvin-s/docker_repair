FROM debian:jessie  
MAINTAINER adirelle+docker@gmail.com  
  
RUN export DEBIAN_FRONTEND=noninteractive \  
&& apt-get update \  
&& apt-get upgrade -y \  
&& apt-get install -y --no-install-recommends locales \  
&& echo "fr_FR.UTF-8 UTF-8" >/etc/locale.gen \  
&& echo "LANG=fr_FR.UTF-8" >/etc/default/locale \  
&& echo "Europe/Paris" >/etc/timezone \  
&& locale-gen \  
&& dpkg-reconfigure tzdata  
  

