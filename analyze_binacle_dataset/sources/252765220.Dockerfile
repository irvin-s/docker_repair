FROM 007backups/borgbackup:1.0.10  
ENV PYTHONUNBUFFERED 1  
WORKDIR /usr/src/app  
  
COPY . ./  
  
RUN set -ex \  
&& python3 -m pip install --no-cache-dir --upgrade /usr/src/app \  
&& rm -rf /usr/src/app/*  
  
CMD ["/usr/local/bin/python3", "-m", "create", "process"]  

