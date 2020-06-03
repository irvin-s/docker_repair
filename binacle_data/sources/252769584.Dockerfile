FROM openjdk:8-jre  
  
ADD DS-5.5.0.zip /tmp/  
  
RUN unzip -q /tmp/DS-5.5.0.zip -d /opt \  
&& /opt/opendj/setup \  
directory-server \  
--rootUserDN "cn=Directory Manager" \  
--rootUserPassword "Password1" \  
--hostname localhost \  
--ldapPort 389 \  
--adminConnectorPort 4444 \  
--baseDN dc=openam,dc=forgerock,dc=org \  
--addBaseEntry \  
--acceptLicense \  
--doNotStart  
  
EXPOSE 389 4444  
  
ENTRYPOINT exec /opt/opendj/bin/start-ds --nodetach  

