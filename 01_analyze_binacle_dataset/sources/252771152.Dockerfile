FROM datamgtcloud/basejava  
  
# Copy application code.  
COPY . /app/  
RUN ./assembleService.sh  

