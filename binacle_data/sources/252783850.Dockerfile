FROM binhnv/hadoop-client  
  
ENV KYLO_VERSION=0.9.0.2 \  
KYLO_HOME="${MY_APP_DIR}/kylo"  
WORKDIR ${KYLO_HOME}  
  
COPY scripts/build /my_build  
RUN /my_build/install.sh && rm -rf /my_build  
  
COPY services ${MY_SERVICE_DIR}  
COPY scripts/init ${MY_INIT_DIR}  

