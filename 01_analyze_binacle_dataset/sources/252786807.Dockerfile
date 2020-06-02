FROM python:3.6.4-alpine  
RUN apk update  
RUN apk add docker  
RUN apk add postgresql-dev  
RUN apk add gcc  
RUN apk add python3-dev  
RUN apk add musl-dev  
  
RUN mkdir -p /carmin-server  
WORKDIR /carmin-server  
  
COPY . /carmin-server  
  
RUN pip3 install --no-cache-dir --trusted-host pypi.python.org .  
  
EXPOSE 8080  
ENV PIPELINE_DIRECTORY=/carmin-assets/pipelines \  
DATA_DIRECTORY=/carmin-assets/data  
  
ENTRYPOINT ["python3"]  
  
CMD ["-m", "server"]  

