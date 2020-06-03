FROM intersoftlab/duplicati:latest  
# RUN groupmod -g 1001 root && usermod -u 1000 root && usermod -g 1001 root  
LABEL org.freenas.interactive="false" \  
org.freenas.version=4 \  
org.freenas.upgradeable="false" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port=8200 \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8200:8200/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/root/.config/Duplicati/\", \  
\"descr\": \"Config directory\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"DUPLICATI_PASS\", \  
\"descr\": \"Duplicati web ui password\" \  
}, \  
{ \  
\"env\": \"MONO_EXTERNAL_ENCODINGS\", \  
\"descr\": \"Encoding (e.g. UTF-8)\" \  
} \  
]"  

