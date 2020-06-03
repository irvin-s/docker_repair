FROM python:2.7-alpine  
  
# Setup the environment  
ENV LISTEN_PORT=2525 \  
MAILIN_USER=mailin \  
MAILIN_HOME=/mailin  
  
# Install dependencies, add user, and link log file  
RUN apk add \--update --no-cache \  
nodejs \  
spamassassin \  
spamassassin-client \  
supervisor \  
wget \  
&& sa-update \  
&& mkdir -p /etc/mail/spamassassin \  
&& adduser -S $MAILIN_USER \  
&& mkdir $MAILIN_HOME \  
&& chown -R $MAILIN_USER $MAILIN_HOME \  
&& chmod -R 777 $MAILIN_HOME \  
&& ln -sf /dev/stdout /var/log/mailin.log  
  
# Install mailin  
RUN npm install -g mailin  
  
# Copy configs into the container  
COPY supervisord.conf /etc/  
COPY spamc.conf /etc/mail/spamassassin/  
  
# Run as a non-priviledged user  
USER $MAILIN_USER  
WORKDIR $MAILIN_HOME  
# Expose a non-priviledged port for SMTP  
EXPOSE 2525  
  
CMD ["supervisord", "--configuration", "/etc/supervisord.conf"]  

