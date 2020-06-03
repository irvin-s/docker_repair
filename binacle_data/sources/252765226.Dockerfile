FROM 007backups/base:1.0  
ENV PYTHONUNBUFFERED 1  
WORKDIR /usr/src/app  
  
COPY . ./  
  
RUN set -ex \  
&& apk add --upgrade --no-cache \  
bash \  
openssh-client \  
postgresql \  
&& python3 -m pip install --no-cache-dir --upgrade /usr/src/app \  
&& rm -rf /usr/src/app/*  
  
CMD ["/usr/local/bin/python3", "-m", "fetch", "process"]  

