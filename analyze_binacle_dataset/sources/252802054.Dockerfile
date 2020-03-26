FROM eeacms/reportek-base-dr:2.0.2  
MAINTAINER "EEA: IDM2 C-TEAM" <eea-edw-c-team-alerts@googlegroups.com>  
  
ENV REPORTEK_DEPLOYMENT=MDR  
  
COPY src/sources.cfg \  
src/mdr-instance.cfg \  
src/base.cfg $ZOPE_HOME/  
  
USER root  
RUN ./install.sh  
USER zope-www  

