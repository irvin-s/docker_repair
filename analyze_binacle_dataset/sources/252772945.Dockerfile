FROM python:3.5  
ADD ./.meta /home/httpd/.meta  
RUN pip install -r /home/httpd/.meta/packages  
  
ADD . /home/httpd/src  
WORKDIR /home/httpd/src  

