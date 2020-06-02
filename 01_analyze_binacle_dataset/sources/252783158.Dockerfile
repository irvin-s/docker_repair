FROM openhab/openhab:2.1.0-snapshot-amd64  
LABEL org.freenas.interactive="false" \  
org.freenas.version="2.0.0" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.capabilities-add="NET_BROADCAST" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8080" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8080:8080/tcp,8443:8443/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/openhab/addons\", \  
\"descr\": \"addons\" \  
}, \  
{ \  
\"name\": \"/conf\", \  
\"descr\": \"Config storage space\" \  
}, \  
{ \  
\"name\": \"/openhab/userdata\", \  
\"descr\": \"Userdata\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Container Timezone\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"User ID 9001\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"Group ID 9001\", \  
\"optional\": true \  
} \  
]"  

