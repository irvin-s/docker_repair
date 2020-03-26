FROM alpine:latest  
  
# create git user group  
RUN addgroup -S -g 5000 git ;\  
adduser -S -H -h /data/git -s /bin/sh -G git -D -u 5000 git ;\  
sed -i -e 's/^git:!:/git:*:/' /etc/shadow  
  
# Install the services  
RUN apk update && apk --update add \  
openssh \  
git \  
gitolite \  
&& rm -rf /tmp/* /var/cache/apk/*  
  
# Improve sshd security  
COPY gitserver_conf/sshd_config /etc/ssh/sshd_config  
  
# add setup script  
COPY gitserver_conf/init /init  
RUN chmod +x /init  
  
EXPOSE 22  
ENTRYPOINT ["/init", "/usr/sbin/sshd"]  
CMD ["-D", "-f", "/etc/ssh/sshd_config"]  

