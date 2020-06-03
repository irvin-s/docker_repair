FROM python:2.7  
RUN pip install protobuf  
COPY *.py /opt/  

