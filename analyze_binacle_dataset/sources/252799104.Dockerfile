FROM python:2.7  
MAINTAINER Dewey Sasser <dewey@sasser.com>  
  
RUN pip install boto3  
  
ADD run.py /run.py  
  
ENTRYPOINT ["/run.py"]  
#CMD ["/run.py"]  

