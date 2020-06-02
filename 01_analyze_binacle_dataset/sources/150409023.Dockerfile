FROM ubuntu

RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget

# python
RUN apt-get install -y python-setuptools
RUN easy_install pip

#supervisor
RUN pip install supervisor

ENV VERSION 2.4.6
RUN wget http://fastdl.mongodb.org/linux/mongodb-linux-x86_64-$VERSION.tgz
RUN tar xzvf mongodb-linux-x86_64-$VERSION.tgz
RUN ln -sfn mongodb-linux-x86_64-$VERSION mongodb

RUN mkdir /data
RUN mkdir /logs

ADD rs-initiate.sh /rs-initiate.sh
ADD supervisord.conf /supervisord.conf

VOLUME [ "/logs" ]
VOLUME [ "/data" ]

EXPOSE 27017
EXPOSE 28017

CMD ["/usr/local/bin/supervisord", "-c", "/supervisord.conf", "-n"]
