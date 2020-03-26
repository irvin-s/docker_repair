FROM python:3-alpine  
MAINTAINER Daniel Kraic <danielkraic@gmail.com>  
  
EXPOSE 5000  
RUN mkdir -p /code  
WORKDIR /code  
  
COPY requirements.txt /code/  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . /code  
  
CMD [ "python", "./web/web.py" ]  

