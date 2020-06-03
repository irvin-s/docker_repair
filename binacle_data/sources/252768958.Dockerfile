FROM python:2.7.13-alpine3.6  
RUN pip install boto3==1.4.7 watchtower==0.4.0  
  
ENV AWS_DEFAULT_REGION us-east-1  
ENV IN_QUEUE_NAME change-me  
  
COPY doer.py /doer.py  
CMD python /doer.py  

