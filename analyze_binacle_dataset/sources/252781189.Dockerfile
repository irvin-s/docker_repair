FROM cjonesy/docker-spark:latest  
MAINTAINER covertspartan  
  
# Install dependencies  
RUN yum install -y gcc-c++ g++ && \  
yum clean all  
  
# Setup an actual Spark User  
RUN useradd -ms /bin/bash -d ${SPARK_HOME} spark  
RUN chown -R spark $SPARK_HOME  
RUN chmod -R g+rw $SPARK_HOME  
  
# Install Airflow Dependencies  
RUN pip install celery==4.1.0 \  
greenlet==0.4.12 \  
eventlet==0.21.0 \  
filechunkio==1.8 \  
greenlet==0.4.12 \  
psycopg2==2.7.3.1 \  
boto==2.46.1 \  
jaydebeapi==0.2.0 \  
redis  
  
# Setup Aiflow user  
ENV AIRFLOW_HOME=/usr/local/airflow  
RUN useradd -ms /bin/bash -d ${AIRFLOW_HOME} airflow  
RUN usermod -a -G spark airflow  
COPY config/airflow.cfg ${AIRFLOW_HOME}/airflow.cfg  
  
#install airflow and expose needed ports  
RUN pip install apache-airflow[hdfs]==1.9.0  
EXPOSE 8080 5555 8793  
# Configure the entry point and set the default user to be `airflow`  
RUN chown -R airflow: ${AIRFLOW_HOME}  
USER airflow  
WORKDIR ${AIRFLOW_HOME}  
  
COPY ./entrypoint.sh /  
ENTRYPOINT ["/entrypoint.sh"]  
CMD ["sh"]  

