ARG  LOCALSTACK_DOCKER_IMAGE_TAG=latest
FROM localstack/localstack:$LOCALSTACK_DOCKER_IMAGE_TAG

COPY bootstrap /opt/bootstrap/

RUN chmod +x /opt/bootstrap/scripts/init.sh
RUN chmod +x /opt/bootstrap/bootstrap.sh

RUN pip install awscli-local 


# We run the init script as a health check
# That way the container won't be healthy until it's completed successfully
# Once the init completes we wipe it to prevent it continiously running
HEALTHCHECK --start-period=10s --interval=1s --timeout=3s --retries=30\
  CMD /opt/bootstrap/bootstrap.sh
