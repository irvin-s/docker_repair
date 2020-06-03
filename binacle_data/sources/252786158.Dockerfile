FROM debian  
MAINTAINER Dan Minear <dan@aududu.com>  
RUN apt-get -y update && apt-get -y install python  
COPY example-client.py /usr/local/bin/  
RUN chmod +x /usr/local/bin/example-client.py  
CMD ["python", "/usr/local/bin/example-client.py"]  

