FROM phusion/baseimage:0.9.17  
# Default configuration: can be overridden at the docker command line  
ENV DEBIAN_FRONTEND=noninteractive \  
HOME=/root \  
LC_ALL=C \  
LDAP_DEBUGLEVEL=0 \  
LDAP_DOMAIN=example.com \  
LDAP_ORGANIZATION="Acme Widgets Inc." \  
LDAP_ROOTPASS=toor  
  
EXPOSE 389  
  
VOLUME /var/lib/ldap  
  
RUN apt-get -y update && \  
rm -rf /etc/service/sshd /etc/my_init.d/00_regen_ssh_host_keys.sh && \  
apt-get install -yq slapd && \  
mkdir -p /etc/service/slapd/supervise && \  
mkdir -p /var/lib/ldap/backups && \  
chown openldap:openldap /var/lib/ldap/backups && \  
apt-get -yq clean && \  
apt-get -yq autoremove && \  
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
ADD slapd.sh /etc/service/slapd/run  
  
RUN chmod 0755 /etc/service/slapd/run  

