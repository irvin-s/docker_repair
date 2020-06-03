FROM python:2.7-slim  
MAINTAINER "EEA: IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>  
  
RUN apt-get update \  
&& apt-get install -y build-essential git \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY src /src  
COPY .gitconfig /root/  
  
RUN pip install -r /src/requirements.txt  
  
WORKDIR /src  
ENTRYPOINT ["/src/docker-entrypoint.sh"]  

