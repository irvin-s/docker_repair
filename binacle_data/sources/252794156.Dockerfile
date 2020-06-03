FROM python:2.7.11  
RUN apt-get update  
RUN pip install --upgrade DukeDSClient  
ENTRYPOINT ["ddsclient"]  
CMD []  

