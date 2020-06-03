FROM python:2.7  
RUN pip install protobuf biostream-schemas requests  
COPY ga4gh-variant.py /opt/  
COPY ga4gh/* /opt/ga4gh/  

