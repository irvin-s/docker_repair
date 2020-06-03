FROM eeacms/kgs:18.3.14  
MAINTAINER "EEA: IDM2 B-Team"  
ENV GRAYLOG_FACILITY=copernicus-insitu-plone  
  
COPY buildout.cfg /plone/instance/  
RUN buildout  

