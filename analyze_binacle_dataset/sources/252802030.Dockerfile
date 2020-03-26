FROM eeacms/kgs:18.1.23  
MAINTAINER "EEA: IDM2 B-Team"  
ENV WARMUP_BIN=/plone/instance/bin/warmup \  
WARMUP_INI=/plone/instance/warmup.ini \  
WARMUP_HEALTH_THRESHOLD=5  
COPY buildout.cfg /plone/instance/  
COPY warmup.ini /plone/instance/  
  
RUN buildout  

