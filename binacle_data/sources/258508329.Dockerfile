FROM openjdk:8-jre

RUN apt-get  update
RUN apt-get install -y python-software-properties 


RUN useradd -u 9000 -m spark 

ENV ZEPPELIN_VERSION      0.6.1
ENV ZEPPELIN_HOME         /usr/local/zeppelin
ENV PATH               $PATH:$ZEPPELIN_HOME/bin

# Installing Spark for Hadoop
RUN wget http://apache.cs.utah.edu/zeppelin/zeppelin-$ZEPPELIN_VERSION/zeppelin-$ZEPPELIN_VERSION-bin-all.tgz   && \
    tar -zxf /zeppelin-$ZEPPELIN_VERSION-bin-all.tgz -C /usr/local/ && \
    ln -s /usr/local/zeppelin-$ZEPPELIN_VERSION-bin-all $ZEPPELIN_HOME && \
    rm /zeppelin-$ZEPPELIN_VERSION-bin-all.tgz

RUN chown -R  spark /usr/local

COPY zeppelin-env.sh /usr/local/zeppelin/conf/zeppelin-env.sh
COPY zeppelin-site.xml /usr/local/zeppelin/conf/zeppelin-site.xml

EXPOSE 8080

CMD ["zeppelin.sh"]
