FROM python:2.7  
MAINTAINER esteban.sastre@tenforce.com  
  
ENV PCAP_READ_DIR "pcap/"  
ENV HAR_OUTPUT_DIR "har/"  
ENV BU_DIR "/app/backups/"  
ENV CONTAINER_DATA_DIR 'containers/'  
ENV CONTAINER_DATA_FILE 'containers.json'  
ENV SLEEP_PERIOD '2'  
RUN mkdir /app  
WORKDIR /app  
  
COPY requirements.txt /app/requirements.txt  
RUN if [ -f requirements.txt ]; then pip install -r requirements.txt; fi  
  
COPY . /app  
  
CMD ["python", "pcap-har-watcher.py"]  

