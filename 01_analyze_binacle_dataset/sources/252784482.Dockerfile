FROM quay.io/keboola/docker-base-php56:0.0.2  
MAINTAINER David Chobotsky <david.chobotsky@bizztreat.com>  
  
WORKDIR /code  
  
#COPY . /code/  
RUN git clone https://github.com/bizztreat/keboola-ex-ewaycrm-writer.git .  
RUN git checkout master  
  
ENTRYPOINT php /code/run.php --data=/data

