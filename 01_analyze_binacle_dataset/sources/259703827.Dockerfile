FROM jupyter/all-spark-notebook:latest

USER root
RUN mkdir -p /usr/share/java && \
    cd /usr/share/java && \
    mkdir -p /home/jovyan/ML_Demo && \
    curl -O https://downloads.mariadb.com/Connectors/java/connector-java-2.3.0/mariadb-java-client-2.3.0.jar && \
    cd /usr/lib && \
    curl -O http://search.maven.org/remotecontent?filepath=junit/junit/4.12/junit-4.12.jar

ADD spark-defaults.conf /usr/local/spark/conf
ADD Python_Example.ipynb /home/jovyan
ADD Scala_Example.ipynb /home/jovyan
ADD Python_mcsapi_connector_Example.ipynb /home/jovyan
ADD Scala_mcsapi_connector_Example.ipynb /home/jovyan
ADD Python_mcsapi_connector_Test.ipynb /home/jovyan
ADD Scala_mcsapi_connector_Test.ipynb /home/jovyan
ADD Python_JDBC_API_Benchmark.ipynb /home/jovyan
ADD Scala_JDBC_API_Benchmark.ipynb /home/jovyan
COPY mnist-model-random-forest.tar.gz /home/jovyan/ML_Demo
ADD Model_Training.ipynb /home/jovyan/ML_Demo
ADD Demo.ipynb /home/jovyan/ML_Demo

RUN apt-get update && \
    apt-get install -y apt-transport-https gnupg && \
    curl https://downloads.mariadb.com/MariaDB/mariadb-columnstore/MariaDB-ColumnStore.gpg.key | apt-key add -

ADD mariadb-columnstore-api.list /etc/apt/sources.list.d

RUN apt-get update && \
    apt-get install -y libuv1 libxml2 libsnappy1v5 bzip2 mariadb-columnstore-api-* && \
    ln -s /usr/lib/python3/dist-packages/columnStoreExporter.py /opt/conda/lib/python3.6/site-packages/ && \
    ln -s /usr/lib/python3/dist-packages/mcsapi_reserved_words.txt /opt/conda/lib/python3.6/site-packages/ && \
    ln -s /usr/lib/python3/dist-packages/pymcsapi.py /opt/conda/lib/python3.6/site-packages/ && \
    ln -s /usr/lib/python3/dist-packages/_pymcsapi.so /opt/conda/lib/python3.6/site-packages/ && \
    mkdir -p /usr/local/mariadb/columnstore/etc && \
    conda install -y -c anaconda pytest mysql-connector-python && \
    cd /home/jovyan/ML_Demo && \
    tar -xf mnist-model-random-forest.tar.gz && \
    rm mnist-model-random-forest.tar.gz && \
    curl -O https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/multiclass/mnist.bz2 && \
    curl -O https://www.csie.ntu.edu.tw/~cjlin/libsvmtools/datasets/multiclass/mnist.t.bz2 && \
    bzip2 -d mnist.bz2 && \
    bzip2 -d mnist.t.bz2 && \
    chmod -R 777 .

COPY Columnstore.xml /usr/local/mariadb/columnstore/etc/Columnstore.xml
