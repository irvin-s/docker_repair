FROM python:2.7  
RUN pip install falcon gunicorn  
RUN mkdir /usr/local/ms17-010  
WORKDIR /usr/local/ms17-010  
  
ADD . ./  
#ADD payloads/ ./  
#ADD scanners/ ./  
#ADD tools/ ./  
EXPOSE 8000  
WORKDIR /usr/local/ms17-010/scanners/  
CMD ["gunicorn", "api", "-b", "0.0.0.0"]

