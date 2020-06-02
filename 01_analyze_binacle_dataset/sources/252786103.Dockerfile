FROM rocoto/couchdb:latest  
  
COPY ./info/README.txt /README.txt  
COPY ./entrypoint-embryo.sh /entrypoint.sh  

