FROM ubuntu:latest  
  
USER root  
RUN apt-get -y update && apt-get install -y python  
RUN apt-get -y install wget  
RUN apt-get -y install git  
  
WORKDIR /tmp  
RUN wget https://bootstrap.pypa.io/get-pip.py  
RUN python get-pip.py  
RUN pip install bottledaemon  
  
RUN groupadd -r bingo && \  
useradd -r -g bingo -d /home/bingo -s /sbin/nologin -c "bingo User" bingo && \  
mkdir /home/bingo && \  
chown -R bingo:bingo /home/bingo  
  
WORKDIR /home  
RUN git clone https://github.com/comdias/bingo.git  
  
EXPOSE 8080  
WORKDIR /home/bingo  
CMD python bingo.py start

