FROM python:2.7.14  
RUN pip install pandas  
RUN pip install protobuf  
RUN pip install xlrd  
RUN pip install biostream-schemas  
  
COPY *.py /opt/  
COPY gdsc_pubchem.table /opt/  
COPY ga4gh/*.py /opt/ga4gh/  

