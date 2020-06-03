FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
git \  
libxml2-dev \  
python-lxml \  
python \  
build-essential \  
make \  
gcc \  
python-dev \  
locales \  
python-pip \  
openssl \  
libssl-dev \  
python-twisted  
  
RUN git clone http://github.com/cwaldbieser/txcasproxy.git && \  
cd txcasproxy && \  
pip install -r requirements.txt  
  
WORKDIR /txcasproxy  
  
ENTRYPOINT ["/usr/bin/twistd"]  
  
CMD ["-n", "casproxy", "--help"]  

