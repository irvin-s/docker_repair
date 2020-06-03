FROM ubuntu:latest  
  
RUN apt-get update \  
&& apt-get install -y --no-install-recommends \  
software-properties-common python-software-properties \  
build-essential libssl-dev libffi-dev \  
git \  
vim \  
wget \  
curl \  
ssh \  
dnsutils \  
iputils-ping \  
ssh \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN add-apt-repository ppa:jonathonf/python-3.6 \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends \  
python3.6 \  
python3.6-dev \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN curl https://bootstrap.pypa.io/get-pip.py | python3.6  
  
RUN pip3.6 install -U \  
ansible \  
virtualenv  

