FROM python:2.7.13  
ADD . /bespin-mailer  
WORKDIR /bespin-mailer  
RUN pip install -r requirements.txt  
CMD python mailsender.py  

