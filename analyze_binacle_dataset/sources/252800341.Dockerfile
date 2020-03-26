FROM python:3.6  
RUN pip install cython  
  
RUN mkdir -p /usr/src/app/requirements && mkdir /usr/src/app/auth  
  
WORKDIR /usr/src/app  
  
ADD ./requirements/requirements.txt /usr/src/app/requirements/  
RUN pip install -r requirements/requirements.txt  
  
ADD . /usr/src/app  
  
EXPOSE 5000  
CMD ["./appRun.sh", "start"]  

