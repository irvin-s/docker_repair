FROM jfloff/alpine-python:2.7-onbuild  
ENV PUPPETDB_HOST="puppetdb"  
ENV PUPPETDB_PORT="8080"  
ENV SSL_VERIFY="False"  
ENV SSL_KEY=""  
ENV SSL_CERT=""  
ENV GROUP_BY=""  
ENV GROUP_BY_TAGS=""  
COPY ./puppetdb.py /puppetdb.py  
COPY ./puppetdb.yml /puppetdb.yml  
  
CMD python ./puppetdb.py --list  

