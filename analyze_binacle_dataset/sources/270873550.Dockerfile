# airflow-docker example

FROM shinyorke/airflow:latest

MAINTAINER Shinichi Nakagawa <spirits.is.my.rader@gmail.com>

# airflow
ENV AIRFLOW_USER=airflow
ENV AIRFLOW_HOME=/usr/local/airflow

# add to dag
USER ${AIRFLOW_USER}
ADD ./airflow_dag_sample ${AIRFLOW_HOME}/dags

# run application
EXPOSE 8080 5555 8793

WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
