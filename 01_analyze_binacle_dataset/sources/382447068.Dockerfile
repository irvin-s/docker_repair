FROM _DOCKER_BASE_
COPY scripts /okchain/baseimage/scripts
RUN /okchain/baseimage/scripts/common/init.sh
RUN /okchain/baseimage/scripts/docker/init.sh
RUN /okchain/baseimage/scripts/common/setup.sh
