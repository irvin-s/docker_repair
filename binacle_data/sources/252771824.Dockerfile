FROM atmoscape/pythonflask  
  
# run python in unbuffered mode so we get logs instantly  
ENV PYTHONUNBUFFERED 1  
# postgres environment variables  
ENV DB_USER postgres  
ENV DB_PASS postgres  
ENV DB_HOST dbhost  
ENV DB_PORT 5432  
ENV DB_NAME torrentfinder  
  
# lets make a working directory  
RUN mkdir /code  
  
# and use it  
WORKDIR /code  
  
# add all files in project directory to '/code/' on container  
ADD ./requirements.txt /code/requirements.txt  
ADD ./torrentfinder /code/torrentfinder  
ADD ./app/ /code/app/  
ADD ./tests/ /code/tests/  
ADD ./run.py /code/run.py  
ADD ./test.py /code/test.py  
  
# install requirements  
RUN pip install --upgrade pip  
RUN pip install -r requirements.txt  
  
CMD ["python", "run.py"]  

