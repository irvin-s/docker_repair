FROM ubuntu:14.04  
MAINTAINER finlay@dragonfly.co.nz  
  
RUN echo "deb http://cran.r-project.org/bin/linux/ubuntu trusty/" > \  
/etc/apt/sources.list.d/cran.list  
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9  
  
RUN ln -s /usr/share/i18n/SUPPORTED /var/lib/locales/supported.d/all  
RUN locale-gen  
  
RUN apt-get update && \  
apt-get install --quiet --no-install-recommends --assume-yes \  
postgresql-client-9.3 \  
git-core \  
pandoc \  
python-pygments \  
jags \  
awscli \  
texlive-full \  
biber \  
r-base-dev \  
libpq-dev \  
r-recommended \  
r-base \  
curl && \  
apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
COPY r_requirements.r /etc/r_requirements.r  
RUN R --slave < /etc/r_requirements.r  

