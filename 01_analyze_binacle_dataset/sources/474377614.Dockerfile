FROM tomcat:7-jre8-alpine
MAINTAINER rochapaulo

RUN apk add --no-cache bash gawk sed grep bc coreutils
RUN apk add --update \
    python \
    python-dev \
    py-pip 
RUN apk add --update curl && \
    rm -rf /var/cache/apk/*

RUN curl -O https://pypi.python.org/packages/8c/8d/1bc41af3429d31e78af39acdf9c45f8e61f65251aec0050e7638d43fd70e/cqlsh-4.1.1.tar.gz && \
    tar -zxvf cqlsh-4.1.1.tar.gz && \
    pip install -U pip setuptools

RUN cd cqlsh-4.1.1 && pip install . && cd ..

COPY wait-for-it.sh wait-for-it.sh
COPY src/cassandra/cql/exec.cql schema.cql
ADD target/crudmicroservicesmiddle.war /usr/local/tomcat/webapps/crudmicroservicesmiddle.war

EXPOSE 8080
