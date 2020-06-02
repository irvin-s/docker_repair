FROM 007backups/base:3.0  
ENV PYTHONUNBUFFERED 1  
ENV PYTHON_B2_VERSION 0.7.2  
WORKDIR /usr/src/app  
  
COPY . ./  
  
RUN set -ex; \  
python3 -m pip install --no-cache-dir --upgrade \  
"b2==$PYTHON_B2_VERSION" \  
"/usr/src/app"; \  
rm -rf "/usr/src/app/"  
  
CMD ["/usr/local/bin/python3", "-m", "replication", "process"]  

