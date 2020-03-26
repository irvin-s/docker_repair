FROM python:2  
ADD . /putio-sync  
WORKDIR /putio-sync  
RUN chmod +x /putio-sync/onComplete.sh && python setup.py install  
CMD ["putiosync", "-c", "/putio-sync/onComplete.sh", "/volumes/incomplete"]  
VOLUME "/volumes/completed"  
VOLUME "/volumes/incomplete"  

