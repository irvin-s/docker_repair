FROM alpine:latest  
MAINTAINER Delta Projects <no-reply@deltaprojects.com>  
  
RUN set -xe \  
&& apk add --no-cache strongswan sudo  
  
COPY content/entrypoint.sh /entrypoint.sh  
RUN chmod 0755 /entrypoint.sh  
  
COPY content/ipsec.conf /etc/ipsec.conf  
  
COPY content/ipsec.secrets /etc/ipsec.secrets  
RUN chmod 0600 /etc/ipsec.secrets  
  
RUN echo 'include strongswan.docker/*.conf' >> /etc/strongswan.conf  
  
# Add group ipsec to sudoers and allow it to run ipsec command  
# useful when you want ispec to apply firewall rules.  
RUN echo '%ipsec ALL=NOPASSWD:SETENV:/usr/sbin/ipsec' > /etc/sudoers.d/ipsec  
RUN chmod 0440 /etc/sudoers.d/ipsec  
  
VOLUME /etc/ipsec.docker /etc/strongswan.docker  
  
EXPOSE 500/udp 4500/udp  
  
ENTRYPOINT ["/entrypoint.sh"]  

