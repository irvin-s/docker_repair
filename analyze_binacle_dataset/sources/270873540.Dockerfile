#
# Docker image for airflow
#

FROM python:3.6-stretch

LABEL maintainer "Shinichi Nakagawa <spirits.is.my.rader@gmail.com>"

# airflow env
ENV AIRFLOW_USER=airflow
ENV AIRFLOW_HOME=/usr/local/airflow
ENV AIRFLOW_DB_USER=airflow


# add to application
RUN mkdir -p ${AIRFLOW_HOME}
WORKDIR ${AIRFLOW_HOME}
RUN useradd -ms /bin/bash -d ${AIRFLOW_HOME} -G sudo ${AIRFLOW_USER} && \
  apt-get install -y --fix-broken && apt-get autoremove &&\
  apt-get update && apt-get -y upgrade && apt-get install -y --no-install-recommends apt-utils \
  mysql-client  \
  default-libmysqlclient-dev \
  libssl-dev \
  libffi-dev
COPY requirements.txt ${AIRFLOW_HOME}
RUN pip install --upgrade pip && pip install -r requirements.txt
ADD ./airflow ${AIRFLOW_HOME}
COPY ./airflow/docker/script/entrypoint.sh /entrypoint.sh
RUN chown -R ${AIRFLOW_USER}.${AIRFLOW_USER} ${AIRFLOW_HOME}

# run application
EXPOSE 8080 5555 8793

USER ${AIRFLOW_USER}
WORKDIR ${AIRFLOW_HOME}
ENTRYPOINT ["/entrypoint.sh"]
