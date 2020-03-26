FROM python:2.7-slim  
  
ENV PROJ_DIR=/gioland  
ENV PYTHONPATH=$PYTHONPATH:$PROJ_DIR/gioland  
  
RUN runDeps="gcc make libldap2-dev libsasl2-dev libssl-dev" \  
&& apt-get update -y \  
&& apt-get install -y --no-install-recommends $runDeps \  
&& rm -vrf /var/lib/apt/lists/* \  
&& mkdir -p $PROJ_DIR/instance  
  
COPY requirements.txt $PROJ_DIR  
WORKDIR $PROJ_DIR  
RUN pip install -r requirements.txt  
  
COPY . $PROJ_DIR  
RUN cd $PROJ_DIR/docs && make html  
  
ENTRYPOINT ["./docker-entrypoint.sh"]  

