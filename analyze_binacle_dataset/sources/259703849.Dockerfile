FROM apache/zeppelin:0.8.0
RUN apt-get update \
    && apt-get install -y vim curl apt-transport-https dirmngr \
    && echo "deb https://downloads.mariadb.com/MariaDB/mariadb-columnstore-api/latest/repo/ubuntu16 xenial main" >> /etc/apt/sources.list \
    && wget -qO - https://downloads.mariadb.com/MariaDB/mariadb-columnstore/MariaDB-ColumnStore.gpg.key | apt-key add - \
    && apt-get update \
    && wget https://archive.apache.org/dist/spark/spark-2.2.0/spark-2.2.0-bin-hadoop2.7.tgz \
    && tar -xzf spark-2.2.0-bin-hadoop2.7.tgz \
    && mv spark-2.2.0-bin-hadoop2.7 /opt/spark \
    && apt-get install -y bzip2 mariadb-columnstore-api-spark mariadb-columnstore-api-pyspark


ENV SPARK_HOME=/opt/spark

RUN mkdir -p  ${SPARK_HOME}/jars && \
    cd  ${SPARK_HOME}/jars && \
    curl -O https://downloads.mariadb.com/Connectors/java/connector-java-2.3.0/mariadb-java-client-2.3.0.jar

COPY zeppelin/spark-defaults.conf ${SPARK_HOME}/conf
COPY zeppelin/bootstrap.sh /zeppelin/bootstrap.sh
RUN chmod 755 /zeppelin/bootstrap.sh
COPY zeppelin/conf/shiro.ini /zeppelin/conf
COPY zeppelin/conf/zeppelin-site.xml /zeppelin/conf
COPY zeppelin/conf/zeppelin-env.sh /zeppelin/conf
#Overwritten in multinode.
COPY Columnstore.xml /usr/local/mariadb/columnstore/etc/Columnstore.xml
COPY notebooks /zeppelin/notebooks
RUN chmod 755 /zeppelin/notebooks/install_notebooks.sh

ENTRYPOINT ["/zeppelin/bootstrap.sh"]
