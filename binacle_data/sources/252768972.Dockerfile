FROM python:3-alpine  
RUN pip install boto3  
COPY src /app/  
CMD ["python", "/app/nights_cloudwatch.py"]  

