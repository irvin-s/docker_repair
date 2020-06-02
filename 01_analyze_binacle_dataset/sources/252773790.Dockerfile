FROM python:2.7  
RUN mkdir -p /usr/src/app  
WORKDIR /usr/src/app  
  
COPY requirements.txt /usr/src/app/  
RUN pip install virtualenv  
RUN pip install --no-cache-dir -r requirements.txt  
RUN virtualenv venv  
  
COPY . /usr/src/app  
  
EXPOSE 5000  
CMD [ "python", "./server/app.py" ]  

