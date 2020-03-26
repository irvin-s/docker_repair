FROM cotdsa/docker-ubuntu:latest  
WORKDIR /usr/src/app  
  
RUN apt-get update \  
&& apt-get install -fy --no-install-recommends \  
gcc \  
libffi-dev \  
libpq-dev \  
libssl-dev \  
python3-dev \  
python3-pip \  
wget \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/*  
  
RUN mkdir -p /usr/src/app \  
&& pip3 install --upgrade \  
pip \  
virtualenv \  
&& virtualenv -p /usr/bin/python3 /usr/src/venv  
  
RUN chown -R ubuntu:ubuntu /usr/src/app /usr/src/venv  
USER ubuntu  

