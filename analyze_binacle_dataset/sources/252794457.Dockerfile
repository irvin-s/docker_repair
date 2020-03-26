FROM ubuntu:trusty  
MAINTAINER Li-Te Chen <datacoda@gmail.com>  
  
# Install prerequisite packages  
RUN \  
apt-get update && \  
apt-get install -y \  
bash tcsh nano mercurial unzip make \  
mono-runtime libmono-corlib2.0-cil libmono-system-runtime2.0-cil \  
mono-gmcs mono-devel mono-xbuild && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
# Mount settings directory as volume for persistence.  
VOLUME /var/lib/vhabot  
  
# =====================================  
# Exposed Configuration Variables  
# =====================================  
# [Req] AO account login  
ENV LOGIN=""  
ENV PASS=""  
# [Req] Super administrator character name  
ENV ADMIN=""  
# [Req] Bot character name  
ENV VHABOT=""  
# [Opt] Server  
ENV DIMENSION="RubiKa"  
# =====================================  
# Specific bitbucket commit hash, or empty for latest  
ENV COMMIT_TAG=""  
# Copy and run deployment script. Downloads from source and builds bot.  
COPY vhabot-deploy.sh /vhabot-deploy.sh  
COPY docker-entrypoint.sh /entrypoint.sh  
  
RUN chmod 755 /entrypoint.sh && \  
chmod 755 /vhabot-deploy.sh && \  
/vhabot-deploy.sh && \  
useradd -u 999 vhabot && \  
chown vhabot.vhabot -R /opt/vhabot/data  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD [""]  

