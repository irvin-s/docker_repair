FROM dcm4che/slapd:2.4.44  
  
# Default configuration: can be overridden at the docker command line  
ENV ARCHIVE_DEVICE_NAME=dcm4chee-arc \  
AE_TITLE=DCM4CHEE \  
ARCHIVE_HOST=127.0.0.1 \  
SCHEDULED_STATION_DEVICE_NAME=scheduledstation \  
SCHEDULED_STATION_AE_TITLE=SCHEDULEDSTATION \  
KEYCLOAK_DEVICE_NAME=keycloak \  
KEYCLOAK_HOST=127.0.0.1 \  
DICOM_PORT=11112 \  
HL7_PORT=2575 \  
SYSLOG_DEVICE_NAME=logstash \  
SYSLOG_HOST=127.0.0.1 \  
SYSLOG_PORT=514 \  
SYSLOG_PROTOCOL=UDP \  
STORAGE_DIR=/opt/wildfly/standalone/data/fs1 \  
SKIP_INIT_CONFIG=false \  
EXT_INIT_CONFIG= \  
IMPORT_LDIF=  
  
COPY ldap /etc/ldap  
COPY bin /usr/bin  

