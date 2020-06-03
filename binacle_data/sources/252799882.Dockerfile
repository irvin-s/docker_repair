FROM digitalr00ts/os:alpine  
  
RUN cd && set -ex && \  
apk \--no-cache add python2 yaml gmp gnupg musl libffi libzmq libsodium && \  
mkdir -p -- /etc/salt/ \  
/srv/etc/salt/master.d/ \  
/srv/etc/salt/ssh.d/ \  
/srv/etc/salt/pki/master/ \  
/srv/salt/ /srv/pillar/ \  
/var/cache/salt/master/  
  
ENTRYPOINT ["/sbin/tini", "-g", "--"]  

