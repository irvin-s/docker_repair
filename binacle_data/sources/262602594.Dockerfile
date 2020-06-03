# ThinkBig Analytics, a Teradata Company

FROM dmalczyk/kstack-kylo:latest

ARG MODULES

COPY scripts/ .

RUN remove-jars.sh

# Updating kylo-services
COPY kylo-jars/ ${KYLO_HOME}/