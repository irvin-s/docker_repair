FROM alpine:latest  
  
ENV AMB_DEFAULT_GID="9000" \  
AMB_DEFAULT_UID="9000" \  
AMB_TIMEZONE="America/Los_Angeles" \  
AMB_SCHEDULE="0 1 * * *" \  
CRONTAB="/var/spool/cron/crontabs/amb"  
VOLUME /data  
  
RUN apk add --update \  
bash \  
gzip \  
mailx \  
mysql-client \  
openssh \  
shadow \  
ssmtp \  
su-exec \  
tzdata \  
&& rm -rf /var/cache/apk/*  
  
# Set up non-root user.  
RUN addgroup -g "$AMB_DEFAULT_GID" amb \  
&& adduser \  
-h "/home/amb" \  
-D `# Don't assign a password` \  
-u "$AMB_DEFAULT_UID" \  
-s "/bin/bash" \  
-G "amb" \  
amb  
  
# Copy files.  
RUN mkdir /app  
COPY automysqlbackup /app/  
COPY automysqlbackup_wrapper.sh /app/  
COPY start.sh /app/  
  
# Set up entry point.  
WORKDIR /app  
ENTRYPOINT ["/app/start.sh"]  

