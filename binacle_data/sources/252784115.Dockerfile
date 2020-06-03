FROM python:2.7  
RUN pip install protobuf biostream-schemas  
COPY *.py /opt/  

