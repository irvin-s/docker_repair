FROM python:3.6  
ENV MU_SPARQL_ENDPOINT http://database:8890/sparql  
ENV MU_APPLICATION_GRAPH http://mu.semte.ch/application  
ENV POLL_RETRIES 10  
ENV ENV prod  
ENV PORT 80  
RUN mkdir /src  
WORKDIR /src  
  
COPY requirements.txt /src/requirements.txt  
RUN pip install -r requirements.txt  
  
COPY . /src  
  
VOLUME /data  
  
ENTRYPOINT ["/src/entrypoint.sh"]  

