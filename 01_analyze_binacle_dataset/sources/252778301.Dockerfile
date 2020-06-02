# Based on https://github.com/dockerfile/rethinkdb  
FROM quay.io/aptible/ubuntu:14.04  
ENV DATA_DIRECTORY /var/db  
  
# Install RethinkDB  
RUN apt-install wget  
ADD files/etc /etc  
RUN wget -O- http://download.rethinkdb.com/apt/pubkey.gpg | apt-key add - && \  
apt-install rethinkdb python-pip  
  
# Install Python driver  
RUN pip install rethinkdb  
  
ADD run-database.sh /usr/bin/  
ADD utilities.sh /usr/bin/  
  
ADD test /tmp/test  
RUN bats /tmp/test  
  
VOLUME ["$DATA_DIRECTORY"]  
WORKDIR $DATA_DIRECTORY  
  
EXPOSE 28015  
ENTRYPOINT ["run-database.sh"]  

