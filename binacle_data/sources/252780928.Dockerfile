FROM alpine  
  
WORKDIR /stack-leader  
  
ENTRYPOINT ./run.sh  
  
ENV SLEEP_INTERVAL 10s  
  
COPY ./run.sh /stack-leader/run.sh  
COPY ./func.sh /stack-leader/func.sh

