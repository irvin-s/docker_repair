FROM python:3.6-slim  
MAINTAINER "EEA: IDM2 C-TEAM" <eea-edw-c-team-alerts@googlegroups.com>  
  
ARG REQFILE=requirements-prod.txt  
  
ENV WORK_DIR=/var/local/european.cache.registry  
  
RUN runDeps="build-essential netcat" \  
&& apt-get update \  
&& apt-get install -y --no-install-recommends $runDeps \  
&& rm -vrf /var/lib/apt/lists/*  
  
COPY requirements*.txt $WORK_DIR/  
WORKDIR $WORK_DIR  
RUN pip install -r $REQFILE  
  
COPY . $WORK_DIR/  
RUN mv docker-entrypoint.sh /bin/  
  
ENTRYPOINT ["docker-entrypoint.sh"]  

