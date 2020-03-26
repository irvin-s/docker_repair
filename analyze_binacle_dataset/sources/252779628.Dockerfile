# docker container running gosa  
# complementoitsm/gosa-slapd  
#docker run -ti --name gosam \  
# -v ${PWD}/config.ldif:/backup/config.ldif \  
# -v ${PWD}/users.ldif:/backup/users.ldif \  
# -v ${PWD}/gosa.conf:/backup/gosa.conf complementoitsm/gosa-slapd  
FROM debian:jessie  
MAINTAINER Complemento - Liberdade e Tecnologia <contato@complemento.net.br>  
  
# set needed variables  
ENV APACHE_RUN_USER www-data  
ENV APACHE_RUN_GROUP www-data  
ENV APACHE_LOG_DIR /var/log/apache2  
  
# install gosa  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive \  
apt-get install -y --force-yes --no-install-recommends \  
gosa gosa-plugin-mail gosa-plugin-sudo gosa-plugin-ldapmanager \  
openssl \  
patch nano slapd procps vim ldap-utils supervisor  
  
# Clean up APT when done.  
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
EXPOSE 80  
VOLUME [ "/etc/gosa" ]  
VOLUME [ "/etc/ldap" ]  
VOLUME [ "/var/lib/ldap" ]  
  
# Supervisor  
RUN mkdir -p /var/log/supervisor  
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf  
  
COPY run.sh /opt/  
RUN chmod +x /opt/run.sh  
  
CMD ["/opt/run.sh"]  

