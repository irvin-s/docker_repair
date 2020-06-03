FROM python:2.7-alpine  
  
RUN apk add --update gcc musl-dev  
RUN pip install sslyze  
ENTRYPOINT ["/usr/local/bin/sslyze_cli.py"]  
CMD ["-h"]  

