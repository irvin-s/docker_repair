# damon/eb  
FROM python:2-slim  
  
RUN pip install --upgrade --no-cache-dir awsebcli  
  
ENTRYPOINT ["eb"]  

