FROM ubuntu:16.04  
RUN apt-get update && \  
apt-get install -y python python-pip python-lzo zlib1g-dev unzip  
  
RUN pip install bx-python  
RUN pip install requests protobuf biostream-schemas pandas  
COPY *.py /opt/  
COPY tcga_pubchem.map /opt/  

