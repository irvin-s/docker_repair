# Docker container for constructing NGS analysis  
  
FROM ubuntu  
MAINTAINER Takeru Nakazato, chalkless@gmail.com  
  
RUN apt-get update && \  
apt-get install -y fastqc && \  
apt-get install -y bowtie2 && \  
apt-get install -y samtools && \  
rm -rf /var/lib/apt/lists/*  
  
CMD ["/bin/bash"]  

