# escape=`  
FROM redash/redash  
  
RUN pip install cassandra-driver  
  
ENV REDASH_ADDITIONAL_QUERY_RUNNERS redash.query_runner.cass

