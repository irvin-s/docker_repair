FROM python:2-alpine  
MAINTAINER Daniel Kraic <danielkraic@gmail.com>  
  
EXPOSE 5100  
RUN mkdir -p /code  
WORKDIR /code  
  
COPY requirements.txt /code/  
RUN pip install --no-cache-dir -r requirements.txt  
  
COPY . /code  
  
CMD [ "python", "./web/web.py" ]  

