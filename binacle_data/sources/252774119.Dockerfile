FROM python:2.7  
ENV PYTHON_UNBUFFERED True  
  
ADD requirements.txt /code/  
  
RUN pip install -r /code/requirements.txt  
  
ADD . /code/  
WORKDIR /code/  
  
CMD python src/python/app.py

