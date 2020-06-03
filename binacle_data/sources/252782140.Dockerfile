#  
# Usage:  
#  
#  
FROM python  
  
RUN yes | pip install cassandra-driver  
RUN yes | pip install natsort  
  
ADD cassandra_migrations.py /usr/local/bin/  
  
RUN ["chmod", "+x", "/usr/local/bin/cassandra_migrations.py"]  
  
CMD [ "python", "/usr/local/bin/cassandra_migrations.py" ]  

