from nextcloud:11.0.2-fpm  
RUN groupmod -g 1001 www-data \  
&& usermod -u 1000 www-data \  
&& usermod -g 1001 www-data  
LABEL org.freenas.interactive="false" \  
org.freenas.version=4 \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/var/www/html/data\", \  
\"descr\": \"the actual data of your Nextcloud\" \  
}, \  
{ \  
\"name\": \"/var/www/html/apps\", \  
\"descr\": \"installed or modified apps\" \  
}, \  
{ \  
\"name\": \"/var/www/html/config\", \  
\"descr\": \"local configuration\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Timezone information, eg Europe/London\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"User ID (not working atm) \", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"Group ID (not working atm)\", \  
\"optional\": true \  
} \  
]"  

