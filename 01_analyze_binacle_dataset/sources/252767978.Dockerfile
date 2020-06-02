FROM python:2.7  
ENV PUPPETDB_HOST="puppetdb"  
ENV PUPPETDB_PORT="8080"  
ENV SSL_VERIFY="False"  
ENV SSL_KEY=""  
ENV SSL_CERT=""  
ENV GROUP_BY=""  
ENV GROUP_BY_TAGS=""  
RUN mkdir -p /usr/src/app  
  
WORKDIR /usr/src/app  
  
COPY ./ansible-inventory-puppetdb /usr/src/app  
RUN pip install --no-cache-dir -r requirements.txt  
  
ENTRYPOINT [ "python", "./puppetdb.py" ]  
CMD [ "--list" ]  

