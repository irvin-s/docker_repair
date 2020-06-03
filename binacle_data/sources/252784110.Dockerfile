FROM python:2.7  
RUN pip install requests  
  
ADD gdc-scan.py /opt/  
ADD gdc-bulk-download.py /opt/

