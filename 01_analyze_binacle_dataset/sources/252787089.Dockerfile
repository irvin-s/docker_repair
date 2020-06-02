FROM ptman/racktables:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="0.20.11" \  
org.freenas.upgradeable="false" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port=9000 \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="9000:9000/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/opt/racktables\", \  
\"descr\": \"Racktables directory\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"DBPASS\", \  
\"descr\": \"Database password\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"GroupID\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"UserID\", \  
\"optional\": true \  
} \  
]" \  
  

