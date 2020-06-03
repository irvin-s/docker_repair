FROM python:3.6  
ENV MU_SPARQL_ENDPOINT http://database:8890/sparql  
ENV MU_RESOURCE_ENDPOINT http://resource  
ENV MU_APPLICATION_GRAPH http://mu.semte.ch/application  
ENV ENV prod  
ENV PORT 80  
RUN mkdir /src  
WORKDIR /src  
  
COPY . /src  
RUN pip install -r requirements.txt  
  
VOLUME /data  
  
ENTRYPOINT ["/src/entrypoint.sh"]

