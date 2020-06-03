FROM python:2  
COPY . /src  
ENTRYPOINT ["python", "/src/src/secret_keys_node/__main__.py"]  
EXPOSE 9999  

