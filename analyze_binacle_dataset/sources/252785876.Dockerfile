FROM debian:jessie  
  
RUN apt-get update && apt-get install -y \  
git \  
libxml2-dev \  
libxslt-dev \  
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
python-twisted \  
libffi-dev  
  
ADD . /txcasproxy/  
  
RUN cd txcasproxy && \  
pip install -r requirements.txt  
  
WORKDIR /txcasproxy  
  
ENTRYPOINT ["/usr/bin/twistd"]  
  
CMD ["-n", "casproxy", "--help"]  

