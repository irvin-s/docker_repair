FROM relateiq/oracle-java7

# apt
RUN apt-get update
RUN apt-get install -y git curl build-essential make gcc wget
RUN apt-get install -y libtool autoconf automake uuid-dev pkg-config unzip

#zero mq
RUN wget http://download.zeromq.org/zeromq-2.1.7.tar.gz
RUN tar -xzf zeromq-2.1.7.tar.gz
RUN cd zeromq-2.1.7 && ./configure && make && make install

#JZMQ
RUN git clone https://github.com/nathanmarz/jzmq.git
RUN cd jzmq/src && touch classdist_noinst.stamp && CLASSPATH=.:./.:$CLASSPATH javac -d . org/zeromq/ZMQ.java org/zeromq/ZMQException.java org/zeromq/ZMQQueue.java org/zeromq/ZMQForwarder.java org/zeromq/ZMQStreamer.java
ENV JAVA_HOME /usr/lib/jvm/java-7-oracle
RUN cd jzmq && ./autogen.sh && ./configure && make && make install

#storm
ENV VERSION 0.8.3-wip3
RUN wget https://dl.dropbox.com/u/133901206/storm-$VERSION.zip && unzip storm-$VERSION.zip
RUN ln -sfn storm-$VERSION storm

ADD storm.log.properties /storm/log4j/storm.log.properties

CMD ["storm/storm"]