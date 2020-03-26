FROM python:3  
RUN pip install --no-cache-dir cryptography pyyaml pydrive  
  
ADD . /data  
  
WORKDIR /data  
  
CMD bash -c  
  
ENTRYPOINT /data/entrypoint.sh

