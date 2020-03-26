# proftpd  
#  
# Installs proftpd server  
#  
# Should you want to  
#  
# VERSION 0.9  
  
FROM ubuntu:16.04  
MAINTAINER John Moser <john.r.moser@gmail.com>  
  
LABEL version="1.0" description="proftpd server on Ubuntu 16.04"  
# Environment variable defaults  
ENV PROFTPD_FTP_PORT="21" \  
PROFTPD_PASSIVE_PORTS="49200-49230" \  
PROFTPD_DEBUG_LEVEL="1" \  
PROFTPD_SERVER_NAME="Proftpd" \  
PROFTPD_REQUIRE_VALID_SHELL="off" \  
PROFTPD_TIMEOUT_NO_TRANSFER="600" \  
PROFTPD_TIMEOUT_STALLED="600" \  
PROFTPD_TIMEOUT_IDLE="600" \  
PROFTPD_DEFAULT_ROOT="~" \  
PROFTPD_MAX_INSTANCES="300" \  
PROFTPD_UMASK="022 022" \  
PROFTPD_AUTH_ORDER="mod_auth_pam.c* mod_auth_unix.c" \  
PROFTPD_TLS="off" \  
PROFTPD_TLS_REQUIRED="off"  
# Expose ports  
#EXPOSE ${PROFTD_FTP_PORT} ${PROFTPD_PASSIVE_PORTS}  
# Get latest updates  
# Initialize proftpd  
RUN apt-get update \  
&& DEBIAN_FRONTEND=noninteractive \  
apt-get install -y proftpd proftpd-mod-vroot proftpd-mod-ldap \  
proftpd-mod-mysql proftpd-mod-pgsql proftpd-mod-sqlite \  
proftpd-mod-tar proftpd-mod-case \  
&& apt-get clean \  
&& find /var/lib/apt/lists/ -type f -delete \  
&& /etc/init.d/proftpd start \  
&& /etc/init.d/proftpd stop \  
&& mkdir -p -m 0755 /etc/proftpd/auth.d \  
/etc/proftpd/user.d \  
&& mkdir -m 000 /var/ftp  
  
# Copy in the proftpd.conf files  
COPY proftpd/*.conf /etc/proftpd/  
COPY run-proftpd.sh /sbin/run-proftpd.sh  
  
# Make the ftp, auth.d, conf.d, and user.d directories volumes  
VOLUME /var/ftp /etc/proftpd/auth.d /etc/proftpd/conf.d /etc/proftpd/user.d  
  
# Clear the bash command and use the proftpd.sh entrypoint  
CMD []  
ENTRYPOINT ["/sbin/run-proftpd.sh"]  
  

