FROM python:2.7.13-alpine  
  
ENV PYTHONUNBUFFERED=1 \  
ROOT=/data  
  
ENV SRC_DIR=${ROOT}/src \  
DEPLOYMENT_DIR=${ROOT}/deployment  
  
COPY deployment ${DEPLOYMENT_DIR}  
  
RUN pip install -r ${DEPLOYMENT_DIR}/requirements.txt  
  
COPY src ${SRC_DIR}  
  
WORKDIR ${SRC_DIR}

