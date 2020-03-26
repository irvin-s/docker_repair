FROM linuxserver/sabnzbd:latest  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="8080" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="8080:8080/tcp,9090:9090/tcp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Sabnzbd config files\" \  
}, \  
{ \  
\"name\": \"/config/admin/certs\", \  
\"descr\": \"SSL certs\" \  
}, \  
{ \  
\"name\": \"/downloads\", \  
\"descr\": \"incomplete downloads volume\" \  
}, \  
{ \  
\"name\": \"/watch\", \  
\"descr\": \"watched folder\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Timezone information, eg America/New_York\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PUID\", \  
\"descr\": \"User ID \", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"PGID\", \  
\"descr\": \"Group ID\", \  
\"optional\": true \  
} \  
]"  
  
# install packages and NzbToMedia Requirements  
RUN \  
apt-get update && \  
apt-get install -yq \  
git \  
python && \  
  
git -C /app clone -q https://github.com/clinton-hall/nzbToMedia.git && \  
chmod -R 777 /app/nzbToMedia/ && \  
rm -rf /var/cache/apt/* /tmp/*  
  
# copy local files  
#COPY root/ /

