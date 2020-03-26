FROM python:3  
RUN pip install -q -U devpi-server  
  
RUN mkdir /devpi-server  
RUN mkdir /devpi-server/server-root  
  
COPY bin/entrypoint.sh /devpi-server/entrypoint.sh  
  
EXPOSE 3141  
ENTRYPOINT ["/devpi-server/entrypoint.sh"]  
  
RUN echo OK  

