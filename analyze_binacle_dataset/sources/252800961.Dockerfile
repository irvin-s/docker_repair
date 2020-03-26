FROM python:3.6  
MAINTAINER Dennis Pattmann <d.pattmann@gmail.com>  
  
RUN pip install awscli  
  
ADD start.sh /start.sh  
  
ENTRYPOINT ["/start.sh"]  

