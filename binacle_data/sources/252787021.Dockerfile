from python:3  
MAINTAINER brainiac2k@gmail.com  
  
COPY . /app  
WORKDIR /app  
  
RUN pip install pipenv  
  
RUN pipenv install --system  
  
CMD ["python", "cox-status.py"]  

