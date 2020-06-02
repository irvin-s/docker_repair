FROM python:3  
ENV PYTHONUNBUFFERED 1  
WORKDIR /usr/src/app  
COPY ./src/requirements.txt requirements.txt  
RUN pip install -r requirements.txt  

