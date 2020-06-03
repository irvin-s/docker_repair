FROM ubuntu:xenial  
RUN apt-get update && apt-get -y install \  
netcat-openbsd curl wget mtr-tiny iputils-ping bind9-host \  
iproute2 net-tools vim tmux ssh lsof screen dtach dnsutils \  
lynx psmisc strace apt-transport-https postgresql-client \  
software-properties-common gnupg jq tcpdump httpie \  
python-setuptools python3-setuptools build-essential \  
gcc g++ make locales traceroute groff \  
&& apt-get clean \  
&& ln -sf /bin/bash /bin/sh  
  
RUN add-apt-repository ppa:git-core/ppa \  
&& apt-get update \  
&& apt-get -y install git \  
&& apt-get clean  
  
ENV _PIP_VERSION=9.0.2 \  
PYTHON_PACKAGES="boto boto3 ipython redis"  
RUN easy_install pip==$_PIP_VERSION \  
&& easy_install3 pip==$_PIP_VERSION \  
&& pip install $PYTHON_PACKAGES \  
&& pip3 install $PYTHON_PACKAGES \  
&& pip3 install awscli  
  
CMD ["bash", "-xec", "exec sleep infinity"]  

