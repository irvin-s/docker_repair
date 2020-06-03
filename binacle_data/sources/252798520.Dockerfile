FROM python:3.6  
  
# install the collector's requirements globally  
ADD requirements.txt /  
RUN pip install -r /requirements.txt  
  
# add a non-root user and give them ownership  
RUN useradd -u 9000 app && \  
# user home directory  
mkdir /home/app && \  
chown -R app:app /home/app && \  
# repo  
mkdir /repo && \  
chown -R app:app /repo && \  
# collector code  
mkdir /usr/src/collector && \  
chown -R app:app /usr/src/collector  
  
# run everything from here on as non-root  
USER app  
  
ADD entrypoint.py /usr/src/collector  
  
WORKDIR /repo  
  
ENTRYPOINT ["python", "/usr/src/collector/entrypoint.py"]  

