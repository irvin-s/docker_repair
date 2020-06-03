FROM python:2.7-alpine  
MAINTAINER Justin Barksdale "jusbarks@cisco.com"  
EXPOSE 8080  
ADD . /app  
WORKDIR /app  
RUN pip install -r requirements.txt  
CMD [ "python", "./chive_web/chive_web.py" ]

