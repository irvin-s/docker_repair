ARG REGISTRY
ARG TAG
FROM ${REGISTRY}/base-tensorflow:${TAG}

############### copy code ###############
ARG MODULE_PATH
COPY $MODULE_PATH /workdir
COPY supervisely_lib /workdir/supervisely_lib

ENV PYTHONPATH /workdir:/workdir/src:/workdir/src/slim:/workdir/supervisely_lib/worker_proto:$PYTHONPATH
WORKDIR /workdir/src
