# 中科大ubuntu base，无需设置deb源
FROM ustclug/ubuntu:16.04

# Set this environment variable to true to set timezone on container start.
ENV SET_CONTAINER_TIMEZONE true
# Default container timezone as found under the directory /usr/share/zoneinfo/.
ENV CONTAINER_TIMEZONE Asia/Shanghai
# URL from which to download Elastalert.
ENV ELASTALERT_URL https://github.com/Yelp/elastalert/archive/master.zip
# Directory holding configuration for Elastalert and Supervisor.
ENV CONFIG_DIR /opt/config
# Elastalert rules directory.
ENV RULES_DIRECTORY /opt/rules
# Elastalert configuration file path in configuration directory.
ENV ELASTALERT_CONFIG ${CONFIG_DIR}/elastalert_config.yaml
# Directory to which Elastalert and Supervisor logs are written.
ENV LOG_DIR /opt/logs
# Elastalert home directory name.
ENV ELASTALERT_DIRECTORY_NAME elastalert
# Elastalert home directory full path.
ENV ELASTALERT_HOME /opt/${ELASTALERT_DIRECTORY_NAME}
# Supervisor configuration file for Elastalert.
ENV ELASTALERT_SUPERVISOR_CONF ${CONFIG_DIR}/elastalert_supervisord.conf
# Alias, DNS or IP of Elasticsearch host to be queried by Elastalert. Set in default Elasticsearch configuration file.
ENV ELASTICSEARCH_HOST elasticsearch
# Port on above Elasticsearch host. Set in default Elasticsearch configuration file.
ENV ELASTICSEARCH_PORT 9200
# start script dir
ENV BIN_DIR /opt/bin

WORKDIR /opt

# set pip sources
RUN mkdir /root/.pip && mkdir ${BIN_DIR}
ADD ./pip.conf /root/.pip/pip.conf
ADD ./get-pip.py /opt/get-pip.py
ADD ./.pydistutils.cfg /root/.pydistutils.cfg
ADD ./start-elastalert.sh ${BIN_DIR}/start-elastalert.sh

# install dependency
RUN set -x && apt-get update && \
    apt-get upgrade -y && \
    apt-get -y install python-setuptools python2.7 python-dev build-essential wget libssl-dev libffi-dev unzip iputils-ping && \
    python get-pip.py && \
    wget ${ELASTALERT_URL} && \
    unzip *.zip && \
    rm *.zip && \
    mv e* ${ELASTALERT_DIRECTORY_NAME} && \
    chmod +x ${BIN_DIR}/start-elastalert.sh

WORKDIR ${ELASTALERT_HOME}

# Install Elastalert.
RUN set -x && python setup.py install && \
    pip install -e . && \
    pip uninstall twilio --yes && \
    pip install twilio==6.0.0 && \
# Install Supervisor.
    easy_install supervisor && \
# Make the start-script executable.
# Create directories. The /var/empty directory is used by openntpd.
    mkdir -p ${CONFIG_DIR} && \
    mkdir -p ${RULES_DIRECTORY} && \
    mkdir -p ${LOG_DIR} && \
    mkdir -p /var/empty 

# Define mount points.
VOLUME [ "${CONFIG_DIR}", "${RULES_DIRECTORY}", "${LOG_DIR}" ]

# Launch Elastalert when a container is started.
CMD ["/opt/bin/start-elastalert.sh"]
