FROM clinseq/autoseq-docker-base  
  
RUN mkdir -p /apps/autoseq  
WORKDIR /apps/autoseq  
  
COPY requirements.txt /apps/autoseq/  
RUN pip install -r requirements.txt  
  
COPY . /apps/autoseq/  
RUN pip install .  
  
ENTRYPOINT ["autoseq"]  

