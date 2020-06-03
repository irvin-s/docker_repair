FROM python:2.7-alpine3.6  
RUN pip install dopy  
  
ENTRYPOINT ["python"]  

