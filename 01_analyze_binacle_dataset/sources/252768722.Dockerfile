FROM alpine:latest  
  
RUN set -ex \  
&& apk --update add openssh \  
&& rm -rf /var/cache/apk/*  
  
RUN set -ex \  
&& addgroup tunnel \  
&& adduser -D tunnel -G tunnel -s /bin/sh \  
&& passwd -u tunnel  
  
RUN set -ex \  
&& mkdir /home/tunnel/.ssh \  
&& chmod 700 /home/tunnel/.ssh \  
&& chown tunnel:tunnel /home/tunnel/.ssh  
  
RUN \  
echo -e "Port 2222\n" \  
"HostKey /etc/ssh/keys/ssh_host_key\n" \  
"PasswordAuthentication no\n" \  
"UseDNS no" >> /etc/ssh/sshd_config  
  
VOLUME /etc/ssh/keys  
VOLUME /home/tunnel/.ssh  
  
EXPOSE 22  
CMD ["/usr/sbin/sshd", "-D", "-f", "/etc/ssh/sshd_config"]  

