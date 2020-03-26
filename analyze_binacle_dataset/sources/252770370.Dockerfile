FROM python:2-onbuild  
RUN mkdir /pick  
  
WORKDIR /pick  
  
VOLUME ["/pick/data", "/pick/model"]  
  
COPY requirements.txt requirements.txt  
  
RUN pip install -r requirements.txt  
  
COPY . .  
  
CMD [ "python", "app.py" ]  

