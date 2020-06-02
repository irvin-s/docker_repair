FROM python:2  
COPY . /usr/src/app  
RUN pip install -r /usr/src/app/requirements.txt  
RUN cd /usr/src/app && python /usr/src/app/parse_transcript_markov.py  
#CMD [ "pwd" ]  
#CMD find /usr/src  
CMD python /usr/src/app/back-and-forth.py  
  

