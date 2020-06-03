FROM scivm/scientific-python-2.7  
MAINTAINER Brian Hicks <brian@brianthicks.com>  
  
ADD . /app  
RUN pip install -r /app/requirements.txt  
  
EXPOSE 8000  
WORKDIR /app  
CMD ["make", "serve"]  

