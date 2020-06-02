FROM atmoscape/pythonflask:latest  
  
# run python in unbuffered mode so we get logs instantly  
ENV PYTHONUNBUFFERED 1  
# postgres environment variables  
ENV DB_USER postgres  
ENV DB_PASS postgres  
ENV DB_HOST dbhost  
ENV DB_PORT 5432  
ENV DB_NAME db  
  
# lets make a working directory  
RUN mkdir /code  
  
# and use it  
WORKDIR /code  
  
# add all files in project directory to '/code/' on container  
ADD ./app/ /code/app/  
ADD ./tests/ /code/tests/  
ADD ./run.py /code/run.py  
ADD ./test.py /code/test.py  
  
CMD ["python", "run.py"]

