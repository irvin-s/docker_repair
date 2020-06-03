FROM ubuntu:16.04  
MAINTAINER Edward Cheadle <edward.cheadle@cambiahealth.com  
ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get -qq update && apt-get install -y -qq --no-install-recommends \  
apt-utils \  
python-yaml python-jinja2 \  
python-httplib2 python-paramiko \  
python-setuptools python-pkg-resources \  
software-properties-common \  
vim openssh-client \  
&& apt-add-repository ppa:ansible/ansible \  
&& apt-get update \  
&& apt-get install ansible -yq --no-install-recommends \  
&& rm -rf /var/lib/apt/lists/* \  
&& groupadd -g 1985 remotemgr \  
&& useradd -m -g remotemgr -u 1985 remotemgr \  
&& /bin/chown -R remotemgr:remotemgr /home/remotemgr \  
&& /bin/mkdir -p /opt/ansible  
WORKDIR /opt/ansible  
USER remotemgr  
ENTRYPOINT ["/bin/bash"]  
  

