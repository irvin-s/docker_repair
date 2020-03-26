FROM colstrom/python  
  
RUN pip install --no-cache-dir awscli  
  
WORKDIR /data  
ENTRYPOINT ["aws"]  

