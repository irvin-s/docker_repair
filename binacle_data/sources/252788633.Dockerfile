FROM csmith/service-reporter-lib:latest  
MAINTAINER Chris Smith <chris87@gmail.com>  
  
COPY *.py /  
  
VOLUME ["/letsencrypt"]  
ENTRYPOINT ["python", "/generate.py"]  

