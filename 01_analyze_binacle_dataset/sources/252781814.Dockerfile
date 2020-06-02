FROM ubuntu:latest  
LABEL org.freenas.autostart="false" \  
org.freenas.interactive="false" \  
org.freenas.version="Latest" \  
org.freenas.upgradeable="true" \  
org.freenas.volumes="[ \  
{ \  
\"name\": \"/data\", \  
\"descr\": \"Data storage space\" \  
} \  
]" \  
org.freenas.settings="[ \  
{ \  
\"env\": \"GMVAULT_TZ\", \  
\"descr\": \"Timezone\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"GMVAULT_DIR\", \  
\"descr\": \"Data directory\", \  
\"optional\": true \  
}, \  
{ \  
\"env\": \"GMVAULT_UID\", \  
\"descr\": \"User ID\", \  
\"optional\": false \  
}, \  
{ \  
\"env\": \"GMVAULT_GID\", \  
\"descr\": \"Group ID\", \  
\"optional\": false \  
}, \  
{ \  
\"env\": \"OAUTH_TOKEN\", \  
\"descr\": \"Google OAuth\", \  
\"optional\": true \  
} \  
]"  
  
ENV GMVAULT_TZ America/New_York  
ENV GMVAULT_DIR /data  
ENV GMVAULT_EMAIL_ADDR test@example.com  
ENV GMVAULT_UID 1001  
ENV GMVAULT_GID 1001  
  
RUN apt-get update && apt-get dist-upgrade -y && apt-get install -y python-pip  
RUN pip install --upgrade pip \  
&& pip install gmvault  
  
VOLUME /data  
  
RUN mkdir /app  
COPY gmvault.sh /app/gmvault.sh  
RUN adduser --system abc --shell /bin/bash  
  
WORKDIR /app  
  
CMD ["/app/gmvault.sh"]  

