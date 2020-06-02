FROM python:3.6  
ENV PYTHONUNBUFFERED 0  
COPY requirements.txt /tmp/requirements.txt  
RUN pip install -r /tmp/requirements.txt  
COPY . /code  
WORKDIR /code  
EXPOSE 8000  
CMD ["/code/start.sh"]

