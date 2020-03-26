FROM python:3.6-alpine  
  
# add a non-root user and give them ownership  
RUN adduser -D -u 9000 app && \  
# repo  
mkdir /repo && \  
chown -R app:app /repo && \  
# collector code  
mkdir /usr/src/collector && \  
chown -R app:app /usr/src/collector  
  
RUN pip install --upgrade pip  
  
# run everything from here on as non-root  
USER app  
  
# add files last  
ADD entrypoint.py /usr/src/collector  
  
WORKDIR /repo  
  
ENTRYPOINT ["python", "/usr/src/collector/entrypoint.py"]  
CMD ["requirements.txt"]  

