FROM debian:jessie  
  
MAINTAINER Dennis Twardowsky <twardowsky@gmail.com>  
  
ENV OPENLDAP_VERSION 2.4.40  
ENV SAMBA_DOC 2:4.1.17  
ENV CONFIG_DIR /etc/ldap  
ENV DATA_DIR /var/lib/ldap  
  
RUN if [ x${HTTP_PROXY} != "x" ]; then \  
echo "Acquire::http::Proxy \"${HTTP_PROXY}\";" > /etc/apt/apt.conf && \  
echo "http_proxy=${HTTP_PROXY}" >> /etc/environment; \  
fi; \  
if [ x${HTTPS_PROXY} != "x" ]; then \  
echo "https_proxy=${HTTPS_PROXY}" >> /etc/environment; \  
fi; \  
if [ x${FTP_PROXY} != "x" ]; then \  
echo "ftp_proxy=${FTP_PROXY}" >> /etc/environment; \  
fi  
  
RUN apt-get update && \  
DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends -y \  
slapd=${OPENLDAP_VERSION}* \  
samba-doc=${SAMBA_DOC}* \  
vim \  
man \  
ldap-utils && \  
apt-get clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN mv ${CONFIG_DIR} ${CONFIG_DIR}.dist  
  
EXPOSE 389  
VOLUME ["${CONFIG_DIR}", "${DATA_DIR}"]  
  
COPY ["res/ldapschemas/schemas.startup.conf", "/tmp/"]  
COPY ["res/ldapschemas/modules/", "/etc/ldap.dist/modules"]  
COPY ["res/ldapschemas/schemas/", "/etc/ldap.dist/schema"]  
  
COPY ["src/sysinit/entrypoint.sh", "/entrypoint.sh"]  
  
ENTRYPOINT ["/entrypoint.sh"]  
  
CMD ["slapd", "-d", "32768", "-u", "openldap", "-g", "openldap"]  
  

