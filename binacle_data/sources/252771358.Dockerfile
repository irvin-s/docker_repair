FROM python:3.4.4  
RUN mkdir workspace  
COPY requirements.pip workspace/requirements.pip  
RUN pip install -r workspace/requirements.pip  
COPY es_config workspace/es_config  
COPY repo_scan workspace/repo_scan  
COPY repo_index workspace/repo_index  
COPY start.sh workspace/  
WORKDIR /workspace  
ENTRYPOINT ["./start.sh"]

