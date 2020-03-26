FROM ubuntu:16.04  
WORKDIR /NGStools/  
  
RUN apt-get update  
  
# -- Scoary General Dependencies ---  
RUN apt-get install -y python-dev python-pip  
RUN pip install ete3 six  
  
# --- Scoary ---  
RUN pip install scoary  
  
WORKDIR /data/

