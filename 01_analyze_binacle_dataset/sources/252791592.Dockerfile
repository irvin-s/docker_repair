#############################################################################  
# Fichier docker mariadb-server  
#############################################################################  
FROM debian:8.3  
MAINTAINER Florestan Bredow <florestan.bredow@daiko.fr>  
  
ENV DEBIAN_FRONTEND noninteractive  
  
RUN apt-get update && apt-get -y install \  
locales \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
# Définis le fuseau horraire  
RUN echo "Europe/Paris" > /etc/timezone && \  
dpkg-reconfigure -f noninteractive tzdata  
  
# Ensure UTF-8 locale  
RUN sed -i -r 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen  
RUN locale-gen  
ENV LANG fr_FR.UTF-8  
ENV LANGUAGE fr_FR.UTF-8  
ENV LC_ALL fr_FR.UTF-8  

