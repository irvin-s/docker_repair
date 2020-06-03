FROM python:2.7  
COPY . /tmp/ht-etl  
RUN pip install /tmp/ht-etl && rm -rf /tmp/ht-etl && mkdir /data  
CMD ["--module", "htetl.main_jobs", "LoadEntityIds", "--local-scheduler"]  
ENTRYPOINT ["luigi"]  

