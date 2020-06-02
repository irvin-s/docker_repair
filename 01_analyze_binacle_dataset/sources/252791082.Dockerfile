FROM archesproject/arches:4.0.0  
ENV BOWER_INSTALL_DIR=${ARCHES_ROOT}/cvast_arches/cvast_arches  
ENV ENTRYPOINT_DIR=/docker/entrypoint  
RUN . ${WEB_ROOT}/ENV/bin/activate &&\  
pip install boto django-storages  
  
COPY ./cvast_arches ${ARCHES_ROOT}/cvast_arches  
COPY ./docker/entrypoint /docker/entrypoint  
  
WORKDIR ${BOWER_INSTALL_DIR}  
RUN bower --allow-root install  
  
RUN chmod -R 700 ${ENTRYPOINT_DIR} &&\  
dos2unix ${ENTRYPOINT_DIR}/*  
  
# Set default workdir  
WORKDIR ${ARCHES_ROOT}/cvast_arches

