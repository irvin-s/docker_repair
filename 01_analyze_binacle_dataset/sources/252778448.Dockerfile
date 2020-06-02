FROM python:3.6-slim  
  
WORKDIR /Service  
  
ADD . /Service  
  
RUN pip install --trusted-host pypi.python.org -r requirements.txt  
  
EXPOSE 80  
  
CMD [ "python","Service.py" ]

