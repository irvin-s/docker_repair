FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y --no-install-recommends\  
build-essential \  
python-dev protobuf-compiler \  
libprotobuf-dev \  
libtokyocabinet-dev \  
python-psycopg2 \  
libgeos-c1v5 \  
libgdal1-dev \  
libspatialindex-dev \  
python-pip \  
python-setuptools \  
&& apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*  
  
RUN pip install imposm rtree  
ENTRYPOINT [ "/usr/local/bin/imposm" ]  

