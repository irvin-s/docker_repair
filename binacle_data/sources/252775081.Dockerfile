FROM python:3.6  
ENV LOGGERS sparql  
ENV MU_SPARQL_ENDPOINT http://database:8890/sparql  
ENV MU_APPLICATION_GRAPH http://mu.semte.ch/application  
ENV ENV prod  
  
ENV ES_HOST elasticsearch  
ENV ES_PORT 9200  
ENV LOG_DIR /logs  
  
VOLUME $LOG_DIR  
  
RUN mkdir /src  
WORKDIR /src  
  
COPY requirements.txt /src/requirements.txt  
RUN pip install -r requirements.txt  
  
COPY . /src  
  
CMD ["/src/run.py", "sparql"]  

