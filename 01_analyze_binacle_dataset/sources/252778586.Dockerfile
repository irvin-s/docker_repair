FROM python:alpine  
MAINTAINER Bryce Thomsen  
WORKDIR /soup  
RUN pip install beautifulsoup4 requests html5lib  
COPY catchpoint.py .  
ENTRYPOINT ["python", "catchpoint.py"]  

