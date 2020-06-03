FROM haugene/transmission-openvpn:1.15  
  
# FreeNAS data  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.privileged="true" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="9091" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="9091:9091/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Config storage space\" \  
}, \  
{ \  
\"name\": \"/data\", \  
\"descr\": \"Downloads volume\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"OPENVPN_PROVIDER\", \  
\"descr\": \"OpenVPN provider to use\" \  
}, \  
{ \  
\"env\": \"OPENVPN_USERNAME\", \  
\"descr\": \"Your OpenVPN username\" \  
}, \  
{ \  
\"env\": \"OPENVPN_PASSWORD\", \  
\"descr\": \"Your OpenVPN password\" \  
}, \  
{ \  
\"env\": \"OPENVPN_CONFIG\", \  
\"descr\": \"OpenVPN config to use\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"OPENVPN_OPTS\", \  
\"descr\": \"Passed to OpenVPN\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"LOCAL_NETWORK\", \  
\"descr\": \"e.g. 192.168.0.0/24\", \  
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
]"  
  

