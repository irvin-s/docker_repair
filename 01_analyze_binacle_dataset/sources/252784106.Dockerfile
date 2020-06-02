FROM python:2.7  
RUN pip install protobuf biostream-schemas  
RUN mkdir /command /in /out  
WORKDIR /out  
COPY *.py /command/  
COPY ga4gh/*.py /command/ga4gh/  
COPY ccle_pubchem.txt /in/  

