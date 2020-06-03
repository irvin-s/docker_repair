FROM ubuntu:16.04  
WORKDIR /  
  
RUN apt-get update && \  
apt-get install -y git gettext python python-pip rpl && \  
apt-get autoremove -y && \  
apt-get -y clean && \  
rm -rf /var/lib/apt/lists/*  
  
RUN pip install mkdocs mkdocs-material  
  
ADD requirements.txt /  
RUN pip install -r requirements.txt  
ADD dockerpuller /app  
  
RUN mkdir /projects  
  
ADD entrypoint.sh /  
CMD /entrypoint.sh  

