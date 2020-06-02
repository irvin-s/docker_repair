FROM python:3-slim  
MAINTAINER Charles Vallance <vallance.charles@gmail.com>  
  
ENV TEST_FILE_DIRECTORY=/app/artifacts  
ENV TEST_FILE_NAME=pytest.xml  
ENV COVERAGE_FILE_NAME=pytest-cov.xml  
  
COPY requirements.txt /opt/bkcwc/requirements.txt  
WORKDIR /opt/bkcwc  
  
RUN pip install -r requirements.txt  
  
COPY src /opt/bkcwc  
  
CMD ["python", "run.py"]  

