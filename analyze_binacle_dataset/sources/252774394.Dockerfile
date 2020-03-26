FROM python:3.6-alpine  
  
ADD . /code/  
RUN find /code -name "*.pyc" -type f -delete | xargs rm -rf  
  
RUN pip install --upgrade pip && \  
pip install -r /code/requirements.txt  
  
WORKDIR /code  
  
CMD ["python", "/code/worker.py"]  

