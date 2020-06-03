FROM quay.io/aptible/debian:wheezy  
  
ENV MONGO_VERSION 2.6.11  
ENV MONGO_SHA1SUM b85fe1e7c1ba96097dd63d263eb70e167c04805d  
  
# Compile and install MongoDB "core"  
ADD ./install-mongodb.sh /install-mongodb.sh  
RUN /install-mongodb.sh  
  
# Install MongoDB tools (we're not compiling those from source)  
ADD templates/mongodb.list /etc/apt/sources.list.d/mongodb.list  
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10 && \  
apt-install "mongodb-org-tools=${MONGO_VERSION}" procps ca-certificates python  
  
ENV MONGO_SSL_MODE preferSSL  
ENV DATA_DIRECTORY /var/db  
ENV SSL_DIRECTORY /etc/ssl/mongo  
RUN mkdir -p "${DATA_DIRECTORY}" "${SSL_DIRECTORY}"  
  
# Tools  
ADD run-database.sh /usr/bin/  
ADD parse_mongo_url.py /usr/bin/  
ADD utilities.sh /usr/bin/  
  
# Integration tests  
ADD test /tmp/test  
RUN bats /tmp/test  
  
VOLUME ["$DATA_DIRECTORY"]  
VOLUME ["$SSL_DIRECTORY"]  
EXPOSE 27017  
ENTRYPOINT ["run-database.sh"]  

