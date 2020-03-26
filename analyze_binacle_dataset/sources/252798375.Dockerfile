FROM golang:1.8  
RUN mkdir -p /agenda-cs  
RUN apt-get update && apt-get install -y sqlite3  
ADD . /agenda-cs/  
WORKDIR /agenda-cs  
RUN cd services/ && rm -f test.db  
RUN cp cli/agenda /usr/local/bin  
  
CMD ["/agenda-cs/services/agenda-server"]  
  

