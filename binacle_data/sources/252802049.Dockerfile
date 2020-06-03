FROM eeacms/zope:2.13.26-1.0  
MAINTAINER "EEA: IDM2 C-TEAM" <eea-edw-c-team-alerts@googlegroups.com>  
  
ENV SETUPTOOLS=33.1.1 \  
ZCBUILDOUT=2.9.5 \  
LOCAL_CONVERTERS_HOST=converter  
  
USER root  
COPY src/* $ZOPE_HOME/  
COPY zope-setup.sh \  
docker-initialize.py /  
  
RUN ./install.sh \  
chown -R 500:500 $ZOPE_HOME  
  
USER zope-www  

