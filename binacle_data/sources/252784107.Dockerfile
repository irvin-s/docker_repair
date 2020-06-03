FROM ubuntu:16.04  
RUN apt-get update && apt-get install -y python python-pip unzip  
RUN pip install protobuf biostream-schemas pandas  
COPY *.py /opt/  
COPY ctdd_pubchem.table /opt/  

