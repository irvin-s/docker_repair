FROM prasanthj/docker-hive-on-tez

## install spark
RUN curl -s http://apache.stu.edu.tw/spark/spark-1.4.1/spark-1.4.1-bin-hadoop2.4.tgz | tar -xz -C /usr/local/
RUN cd /usr/local \
    && ln -s spark-1.4.1-bin-hadoop2.4 spark

ENV SPARK_JAR hdfs:///spark/spark-assembly-1.4.1-hadoop2.4.0.jar \
    SPARK_HOME /usr/local/spark \
    PATH $PATH:$SPARK_HOME/bin:$HADOOP_PREFIX/bin \
    PYTHONPATH $SPARK_HOME/python/:$PYTHONPATH \
    PYTHONPATH $SPARK_HOME/python/lib/py4j-0.8.2.1-src.zip:$PYTHONPATH

ADD hive-site.xml $SPARK_HOME/conf/hive-site.xml
ADD hive-bootstrap.sh /etc/hive-bootstrap.sh
RUN chown root:root /etc/hive-bootstrap.sh && chmod 700 /etc/hive-bootstrap.sh

## install ipython
RUN apt-get update && apt-get -y install python-pip python-dev build-essential python-tk libpng-dev liblapack-dev libatlas-base-dev  gfortran libfreetype6-dev  wget pkg-config python-matplotlib\ 
    && pip install pip --upgrade \
    && pip install -U jupyter \
    && pip install pandas scipy scikit-learn 


CMD /etc/hive-bootstrap.sh &&  /usr/local/spark/sbin/start-master.sh && IPYTHON_OPTS="notebook --no-browser --ip=0.0.0.0 --port 8888 --notebook-dir=/home/" /usr/local/spark/bin/pyspark
