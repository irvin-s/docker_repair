FROM ubuntu  
  
  
RUN apt update && apt install -y --no-install-recommends \  
python \  
git \  
ca-certificates \  
openjdk-8-jre-headless \  
bzip2 \  
gzip \  
unzip \  
build-essential \  
zlib1g-dev \  
libncurses5-dev \  
python-wget \  
python-matplotlib \  
python-biopython  
  
RUN git clone https://github.com/holmrenser/IOGA.git  
  
ENV PATH "$HOME/IOGA:$PATH"  
RUN cd IOGA/ && \  
python setup_IOGA.py  
  
VOLUME /data  
  
WORKDIR /data

