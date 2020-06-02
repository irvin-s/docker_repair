FROM ubuntu  
  
RUN apt update && apt upgrade --yes  
  
RUN apt install --yes \  
git \  
bowtie2 \  
ncbi-blast+  
  
RUN apt install --yes wget python && \  
cd /tmp/ && \  
wget http://cab.spbu.ru/files/release3.10.1/SPAdes-3.10.1-Linux.tar.gz && \  
tar -xzf SPAdes-3.10.1-Linux.tar.gz && \  
mv SPAdes-3.10.1-Linux/ /opt//spades/ && \  
rm SPAdes-3.10.1-Linux.tar.gz  
  
ENV PATH "/opt/spades/bin:$PATH"  
RUN git clone "https://github.com/Kinggerm/GetOrganelle" && \  
cd GetOrganelle && \  
git pull  
  
ENV PATH "$HOME/GetOrganelle:$PATH"  
ENV PATH "$HOME/GetOrganelle/Utilities:$PATH"  
VOLUME /data  
  
WORKDIR /data

