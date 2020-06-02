FROM a1fred/docker-python-phantomjs  
MAINTAINER Jeff Billimek <jeff@billimek.com>  
  
ADD . /src  
WORKDIR /src  
  
RUN pip install -r requirements.txt  
  
CMD ["python", "-u", "/src/InfluxdbComcast.py"]  

