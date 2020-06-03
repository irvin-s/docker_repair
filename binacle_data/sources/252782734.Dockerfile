FROM python:3.5.1  
MAINTAINER Dave Finster <davefinster@me.com>  
  
WORKDIR /usr/app  
  
COPY ./ ./  
  
RUN pip install flask sqlalchemy Flask-Login Flask-OAuthLib  
  
EXPOSE 5000  
CMD [ "python", "runserver.py" ]

