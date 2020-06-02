FROM python:2.7
RUN pip install docker-py==0.3.2
COPY docker-export-volumes.py /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-export-volumes.py"]
