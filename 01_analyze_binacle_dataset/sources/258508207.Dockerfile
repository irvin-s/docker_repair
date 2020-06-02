FROM dckreg:5000/hadoop:{{ HADOOP_VERSION }}

ENV HBASE_VERSION    {{ HBASE_VERSION }}
ENV HBASE_HOME       /opt/hbase

ENV PHOENIX_HOME   /opt/phoenix
ENV PHOENIX_VERSION {{ PHOENIX_VERSION }}

ENV PATH             $PATH:$HBASE_HOME/bin:$PHOENIX_HOME/bin

RUN DEBIAN_FRONTEND=noninteractive  && \
    wget https://www.apache.org/dist/hbase/$HBASE_VERSION/hbase-$HBASE_VERSION-bin.tar.gz   && \
    tar -zxf hbase-$HBASE_VERSION-bin.tar.gz && \
    rm hbase-$HBASE_VERSION-bin.tar.gz && \
    mv hbase-$HBASE_VERSION $HBASE_HOME

RUN wget http://apache.cs.utah.edu/phoenix/apache-phoenix-$PHOENIX_VERSION/bin/apache-phoenix-$PHOENIX_VERSION-bin.tar.gz   && \
    tar -zxf apache-phoenix-$PHOENIX_VERSION-bin.tar.gz && \
    rm apache-phoenix-$PHOENIX_VERSION-bin.tar.gz && \
    mv apache-phoenix-$PHOENIX_VERSION-bin $PHOENIX_HOME

RUN cp $PHOENIX_HOME/phoenix-$PHOENIX_VERSION-server.jar $HBASE_HOME/lib/

RUN useradd -u 9001 -m hbase 

RUN chown -R hbase $HBASE_HOME
RUN chown -R hbase $PHOENIX_HOME

