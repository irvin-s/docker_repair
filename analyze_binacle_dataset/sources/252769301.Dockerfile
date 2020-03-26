FROM foxusa/opennote:latest  
LABEL org.freenas.interactive="true" \  
org.freenas.version="0.1" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="7890" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="80:7890/tcp,433:7891/tcp" \  
org.freenas.autostart="true"  

