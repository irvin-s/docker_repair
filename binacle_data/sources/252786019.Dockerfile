FROM dkruger/cron:latest  
  
ENV \  
RSYNC_CRONTAB="0 0 * * *" \  
RSYNC_OPTIONS="--archive --timeout=3600" \  
RSYNC_UID="0" \  
RSYNC_GID="0"  
RUN set -x; \  
apk add --no-cache --update rsync sudo \  
&& rm -rf /tmp/* \  
&& rm -rf /var/cache/apk/*  
  
VOLUME ["/rsync_src", "/rsync_dst"]  
  
COPY rsync-entrypoint.sh /entrypoint.d/rsync.sh  

