FROM eeacms/kgs:18.5.9  
MAINTAINER "EEA: IDM2 B-Team"  
ENV GRAYLOG_FACILITY=copernicus-land-plone  
ENV SENTRY_DSN=  
  
COPY buildout.cfg /plone/instance/  
RUN buildout  

