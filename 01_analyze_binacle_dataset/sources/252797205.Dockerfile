FROM python:2  
COPY . /src  
ENTRYPOINT ["python", "/src/src/sequence_node/__main__.py"]  
EXPOSE 9999  

