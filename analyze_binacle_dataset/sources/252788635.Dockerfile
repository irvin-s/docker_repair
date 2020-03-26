FROM csmith/service-reporter-lib:latest  
MAINTAINER Chris Smith <chris87@gmail.com>  
  
RUN \  
pip install \  
docker-py  
  
COPY *.py /  
ENTRYPOINT ["python", "/report.py"]  

