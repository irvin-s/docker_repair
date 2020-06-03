FROM bmya/odoo  
  
MAINTAINER Ignacio Cabrera <cabrerabywaters@gmail.com>  
  
USER root  
  
##########################################  
# Locales for Spanish Language  
##########################################  
ENV DEBIAN_FRONTEND noninteractive  
RUN apt-get update -qq && apt-get install -y locales -qq  
RUN echo 'es_AR.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen  
RUN echo 'es_CL.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen  
RUN echo 'es_ES.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen  
RUN echo 'es_US.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen  
RUN echo 'C.UTF-8 UTF-8' >> /etc/locale.gen && locale-gen  
RUN dpkg-reconfigure locales && /usr/sbin/update-locale LANG=C.UTF-8  
ENV LANG C.UTF-8  
ENV LANGUAGE C.UTF-8  
ENV LC_ALL C.UTF-8  
  
  
##########################################  
# Install some dependencies  
##########################################  
RUN apt-get update \  
&& apt-get install -y \  
python-pip git vim ghostscript  
  
RUN git clone https://github.com/OCA/pos.git /mnt/extra-addons  
  
RUN git clone https://github.com/OCA/l10n-spain.git /mnt/extra-addons  
  
  
  
  
  
USER odoo  

