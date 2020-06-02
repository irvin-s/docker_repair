FROM python:3.6-alpine  
  
# add a non-root user and give them ownership  
RUN adduser -D -u 9000 app && \  
# repo  
mkdir /repo && \  
chown -R app:app /repo && \  
# actor code  
mkdir /usr/src/actor && \  
chown -R app:app /usr/src/actor  
  
ADD requirements.txt /usr/src/actor  
RUN pip install -r /usr/src/actor/requirements.txt  
  
# run everything from here on as non-root  
USER app  
  
ADD entrypoint.py /usr/src/actor  
  
WORKDIR /repo  
  
ENTRYPOINT ["python", "/usr/src/actor/entrypoint.py"]  

