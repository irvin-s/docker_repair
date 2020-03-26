FROM airhacks/wildfly:11.0.0.Final
MAINTAINER Hendrik Ebbers, canoo.com
COPY integration-tests.war ${DEPLOYMENT_DIR}