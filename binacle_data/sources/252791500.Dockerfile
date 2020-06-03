FROM ubuntu:16.04  
MAINTAINER "Rsrp Sinr" <rsrp.sinr@gmail.com>  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
locales \  
&& rm -rf /var/lib/apt/lists/*  
RUN locale-gen en_US.UTF-8  
ENV LANG en_US.UTF-8  
ENV LANGUAGE en_US:en  
ENV LC_ALL en_US.UTF-8  
#---------------------------------------------  
# OldapD  
#---------------------------------------------  
ENV OLDAPD_VERSION 0.1  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install -y \  
ca-certificates \  
expect \  
ldap-utils \  
rsyslog \  
slapd \  
supervisor \  
phpldapadmin \  
db5.3 \  
apache2-utils \  
gnutls-bin \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
COPY ldap-status /usr/local/bin/ldap-status  
RUN chmod +x /usr/local/bin/ldap-status  
  
VOLUME ["/data"]  
  
VOLUME ["/var/run/slapd"]  
  
ENV LDAP_DOMAIN=example.com  
ENV LDAP_ORGANIZATION=Example  
ENV LDAP_ADMIN_PASSWORD=admin  
  
ENV LDAP_CONFIG_DN=cn=admin,cn=config  
ENV LDAP_CONFIG_PASSWORD=admin  
  
ENV LDAP_LOG_LEVEL=${LDAP_LOG_LEVEL:-256}  
  
# Ports:  
# 389: LDAP (unsecured or TLS-secured using STARTTLS)  
# 636: LDAP (secured using TLS)  
EXPOSE 389 636  
# User management helper scripts  
COPY utils/* /usr/local/bin/  
RUN chmod +x /usr/local/bin/oldapd_*  
  
ADD entrypoint.sh /entrypoint.sh  
RUN chmod 700 /entrypoint.sh  
  
ADD app.sh /app.sh  
RUN chmod 700 /app.sh  
  
ENTRYPOINT ["/entrypoint.sh"]  

