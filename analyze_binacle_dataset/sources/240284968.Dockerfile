FROM redash/base:latest

# Oracle support
RUN mkdir -p /opt/oracle
ADD ./instantclient/ .

RUN unzip instantclient-basic-linux.x64-12.1.0.2.0.zip -d /opt/oracle \
  && unzip instantclient-sdk-linux.x64-12.1.0.2.0.zip -d /opt/oracle  \
  && mv /opt/oracle/instantclient_12_1 /opt/oracle/instantclient \
  && ln -s /opt/oracle/instantclient/libclntsh.so.12.1 /opt/oracle/instantclient/libclntsh.so \
  && ln -s /opt/oracle/instantclient/libocci.so.12.1 /opt/oracle/instantclient/libocci.so \
  && rm instantclient-basic-linux.x64-12.1.0.2.0.zip \
  && rm instantclient-sdk-linux.x64-12.1.0.2.0.zip

ENV LD_LIBRARY_PATH="/opt/oracle/instantclient" OCI_HOME="/opt/oracle/instantclient" OCI_LIB_DIR="/opt/oracle/instantclient" OCI_INCLUDE_DIR="/opt/oracle/instantclient/sdk/include" ORACLE_HOME="/opt/oracle/instantclient"
RUN echo '/opt/oracle/instantclient/' | tee -a /etc/ld.so.conf.d/oracle_instant_client.conf && ldconfig && pip install cx_Oracle==5.2