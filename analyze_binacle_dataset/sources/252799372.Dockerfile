  
FROM python:3.6.1  
WORKDIR /app  
  
COPY requirements.txt requirements.txt  
COPY dev-requirements.txt dev-requirements.txt  
  
RUN pip install -r requirements.txt  
RUN pip install -r dev-requirements.txt

