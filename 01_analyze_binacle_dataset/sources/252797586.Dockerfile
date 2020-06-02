FROM cobli/ubuntu-init:14.04  
  
RUN apt-get update && \  
apt-get install -y --no-install-recommends \  
python-pip python-setuptools python-wheel python-dev build-essential \  
libssl-dev libffi-dev && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install -U setuptools wheel  

