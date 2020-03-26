FROM alpine:3.7  
RUN apk add --no-cache \  
tini \  
shadow \  
python \  
python-dev \  
py-pip \  
build-base \  
openssh \  
jq \  
&& pip install awscli  
  
COPY ./sshd_config /etc/ssh/sshd_config  
COPY ./entrypoint.sh /entrypoint.sh  
  
ENV SSH_USER ssh-user  
ENV SSH_GROUP ssh-user  
ENV SSH_PUBKEY notset  
  
VOLUME ["/etc/sshd"]  
EXPOSE 22  
ENTRYPOINT ["/sbin/tini", "--", "/entrypoint.sh"]  
CMD ["/usr/sbin/sshd", "-De"]  

