FROM jrcs/letsencrypt-nginx-proxy-companion:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.upgradeable="false" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/etc/nginx/certs\", \  
\"descr\": \"Path to SSL certificates\" \  
}, \  
{ \  
\"name\": \"/etc/nginx/vhost.d\", \  
\"descr\": \"Path to host configurations\", \  
\"readonly\": \"true\" \  
}, \  
{ \  
\"name\": \"/etc/nginx/htpasswd\", \  
\"descr\": \"Path to htpasswd files named the same as the VIRTUAL_HOST\", \  
\"readonly\": \"true\" \  
} \  
]" \  
org.freenas.static-volumes="[ \  
{ \  
\"container_path\": \"/var/run/docker.sock\", \  
\"host_path\": \"/var/run/docker.sock\", \  
\"readonly\": \"true\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"NGINX_PROXY_CONTAINER\", \  
\"descr\": \"Name or id of the nginx-proxy container\", \  
\"optional\": true \  
} \  
]"

