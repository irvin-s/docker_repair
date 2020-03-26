FROM python:2.7  
  
RUN apt-get update && \  
apt-get install -y wget ca-certificates && \  
apt-get purge -y --auto-remove && rm -rf /var/lib/apt/lists/*  
  
RUN pip install redis flower  

