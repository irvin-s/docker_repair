FROM educatedwarrior/mineos-docker:mineos-wily  
MAINTAINER Educated Warrior  
  
LABEL org.freenas.interactive="true" \  
org.freenas.version="1.02" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="https" \  
org.freenas.web-ui-port="8443" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8443:8443/tcp,25565:25565/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/var/games/minecraft\", \  
\"descr\": \"Minecraft Game Folder\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"USER_ID\", \  
\"descr\": \"User ID \", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"USER_NAME\", \  
\"descr\": \"User Name\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"USER_PASSWORD\", \  
\"descr\": \"User Password\", \  
\"optional\": false \  
} \  
]"  
  

