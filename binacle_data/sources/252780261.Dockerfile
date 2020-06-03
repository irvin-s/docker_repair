# This image includes:  
#  
# azukiapp/deploy:  
# * Alpine Linux  
# * Ansible  
# * SSHPass  
FROM alpine:3.4  
MAINTAINER Azuki <support@azukiapp.com>  
  
RUN mkdir -p /azk/deploy  
WORKDIR /azk/deploy  
  
RUN packages=' \  
bash \  
openssh \  
sshpass \  
git \  
curl \  
openssl \  
ansible \  
' \  
set -x \  
&& apk --update add $packages \  
&& rm -rf /var/cache/apk/*  
  
COPY playbooks ./playbooks  
COPY cmds ./cmds  
COPY utils ./utils  
COPY *.sh ./  
  
ENTRYPOINT ["/azk/deploy/deploy.sh"]  
CMD ["/azk/deploy/deploy.sh"]  

