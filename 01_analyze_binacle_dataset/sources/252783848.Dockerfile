FROM binhnv/hive-base  
MAINTAINER "Binh Van Nguyen<binhnv80@gmail.com>"  
ENV HIVE_SERVICE_NAME="hive" \  
HIVE_JDBC_PORT=10000 \  
HIVE_SCHEMA_DIR="${MY_APP_DATA_DIR}/hive/schema"  
EXPOSE ${HIVE_JDBC_PORT}  
  
WORKDIR ${HIVE_HOME}  
VOLUME ${HIVE_SCHEMA_DIR}  
  
COPY services ${MY_SERVICE_DIR}  
COPY scripts/startup ${MY_STARTUP_DIR}  

