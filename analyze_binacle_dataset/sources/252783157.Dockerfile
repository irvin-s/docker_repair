FROM jshridha/motioneye:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8765" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8081:8081/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Config storage space\" \  
}, \  
{ \  
\"name\": \"/home/nobody/media\", \  
\"descr\": \"Webcam image stills\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Motioneye container Timezone\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"Motioneye User ID\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"Motioneye Group ID\", \  
\"optional\": true \  
} \  
]"  

