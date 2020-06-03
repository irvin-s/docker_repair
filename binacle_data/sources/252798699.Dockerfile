FROM python:3  
COPY . /python  
  
RUN cd /python && \  
pip3 install --no-cache-dir -r requirements.txt  
  
ENTRYPOINT [ "python3", "/python/connector.py" ]  

