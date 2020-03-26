FROM zuhkov/paperwork:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8888" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="80:8888/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"paperwork persistant data volume\" \  
} \  
]"  

