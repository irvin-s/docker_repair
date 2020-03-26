FROM plone:4.3.10  
ENV EDW_LOGGER_PUBLISHER=false \  
EDW_LOGGER_USER_ID=true \  
GRAYLOG=logcentral.eea.europa.eu:12201 \  
GRAYLOG_FACILITY=eea.docker.kgs \  
GOSU_VERSION=1.10 \  
EEA_KGS_VERSION=18.6.5  
LABEL eea-kgs-version=$EEA_KGS_VERSION \  
maintainer="EEA: IDM2 A-Team <eea-edw-a-team-alerts@googlegroups.com>"  
  
USER root  
RUN mv /docker-entrypoint.sh /plone-entrypoint.sh \  
&& rm -vrf /plone/instance/* /plone/instance/.installed.cfg  
  
COPY src/docker/* /  
COPY src/plone/* /plone/instance/  
RUN /docker-setup.sh  

