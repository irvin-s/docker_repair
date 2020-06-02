FROM python:3  
RUN pip install pylint  
  
VOLUME /usr/app  
WORKDIR /usr/app  
ENV PYTHONPATH /usr/app  
  
CMD [ "pylint"]  

