FROM linuxserver/transmission:latest  
#ENV TRANSMISSION_VERSION=2.92-r3  
LABEL org.freenas.interactive="false" \  
org.freenas.version="1" \  
org.freenas.upgradeable="true" \  
org.freenas.expose-ports-at-host="true" \  
org.freenas.autostart="true" \  
org.freenas.web-ui-protocol="http" \  
org.freenas.web-ui-port="9091" \  
org.freenas.web-ui-path="" \  
org.freenas.port-mappings="9091:9091/tcp,51413:51413/tcp,51413:51413/udp" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/config\", \  
\"descr\": \"Config storage space\" \  
}, \  
{ \  
\"name\": \"/watch\", \  
\"descr\": \"Watch folder for torrent files\" \  
}, \  
{ \  
\"name\": \"/downloads\", \  
\"descr\": \"Downloads volume\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"TZ\", \  
\"descr\": \"Timezone - eg Europe/London\", \  
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
  
# install packages and NzbToMedia Requirements  
RUN \  
#apk del --no-cache \  
#transmission-cli \  
#transmission-daemon && \  
apk add --no-cache \  
git \  
python && \  
#transmission-cli=${TRANSMISSION_VERSION} \  
#transmission-daemon=${TRANSMISSION_VERSION} && \  
  
  
git -C /app clone -q https://github.com/clinton-hall/nzbToMedia.git && \  
  
rm -rf /var/cache/apk/* /tmp/*  
  
# copy local files  
#COPY root/ /

