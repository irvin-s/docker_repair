FROM ubuntu:14.04  
EXPOSE 8888  
RUN apt-get update -qq  
RUN apt-get install -y -qq build-essential python3-dev python3-pip  
RUN pip3 install tornado redis  
  
ENV PYTHONPATH /usr/local/src/redis-demo  
  
RUN mkdir /usr/local/src/redis-demo  
ADD . /usr/local/src/redis-demo  
  
WORKDIR /usr/local/src/redis-demo  
  
ENTRYPOINT [ "python3" ]  
CMD [ "__init__.py" ]  

