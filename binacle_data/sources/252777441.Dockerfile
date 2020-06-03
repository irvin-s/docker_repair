FROM python:3.7-rc-slim  
MAINTAINER chabare95@gmail.com  
  
WORKDIR /usr/src/app  
  
COPY . .  
  
RUN pip install --no-cache-dir -r requirements.txt  
  
CMD python -B -O -OO main.py  

