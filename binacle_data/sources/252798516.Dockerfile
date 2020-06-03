FROM python:3.6-alpine  
  
RUN apk --no-cache add git  
  
# install the collector's requirements globally  
ADD requirements.txt /  
RUN pip install -r /requirements.txt  
  
# add a non-root user and give them ownership  
RUN adduser -D -u 9000 app && \  
# repo  
mkdir /repo && \  
chown -R app:app /repo && \  
# actor code  
mkdir /usr/src/actor && \  
chown -R app:app /usr/src/actor  
  
# run everything from here on as non-root  
USER app  
  
ADD entrypoint.py /usr/src/actor  
  
WORKDIR /repo  
  
ENTRYPOINT ["python", "/usr/src/actor/entrypoint.py"]  

