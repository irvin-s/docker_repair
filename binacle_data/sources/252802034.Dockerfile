FROM eeacms/kgs:18.5.29  
MAINTAINER "EEA: IDM2 S-Team"  
ENV GRAYLOG_FACILITY=wise-plone  
  
RUN buildout  
  
COPY buildout.cfg /plone/instance/  
RUN buildout -N  

