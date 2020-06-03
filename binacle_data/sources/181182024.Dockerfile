FROM tomcat:8.5

ARG COMPUTE_THREDDS_VER

ENV COMPUTE_THREDDS_VER ${COMPUTE_THREDDS_VER}

ENV TINI_VERSION v0.18.0

ENV JAVA_HEAP_INIT 512m
ENV JAVA_HEAP_MAX 1g

RUN wget http://artifacts.unidata.ucar.edu/content/repositories/unidata-releases/edu/ucar/tds/${COMPUTE_THREDDS_VER}/tds-${COMPUTE_THREDDS_VER}.war \
	-O webapps/threddsCWT.war

RUN wget https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini -O /tini && \
  chmod +x /tini

COPY docker/thredds/setenv.sh bin/
COPY docker/thredds/entrypoint.sh entrypoint.sh
COPY docker/thredds/catalog.xml catalog.xml
COPY docker/thredds/threddsConfig.xml threddsConfig.xml
COPY docker/thredds/server.xml conf/

ENTRYPOINT ["/tini", "--"]

CMD ["/bin/bash", "./entrypoint.sh"]
