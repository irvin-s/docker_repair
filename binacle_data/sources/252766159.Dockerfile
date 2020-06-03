FROM python:3-alpine  
RUN pip install boto3 flask aws_lambda_logging requests  
COPY . /srv/app  
WORKDIR /srv/app  
CMD /srv/app/timetoinservice/timetoinservice.py  

