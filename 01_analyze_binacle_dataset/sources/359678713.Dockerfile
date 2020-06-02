FROM airhacks/glassfish
COPY ./target/quickstart.war ${DEPLOYMENT_DIR}
