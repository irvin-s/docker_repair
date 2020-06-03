FROM ummidock/ubuntu_base:latest  
  
WORKDIR /NGStools/  
  
RUN apt-get update  
  
# -- General Dependencies ---  
RUN apt-get install -y git zlib1g-dev make gcc  
  
#Seqtk  
RUN git clone https://github.com/lh3/seqtk.git;  
WORKDIR seqtk  
RUN make  
ENV PATH="/NGStools/seqtk:${PATH}"  
WORKDIR /NGStools/  
  

