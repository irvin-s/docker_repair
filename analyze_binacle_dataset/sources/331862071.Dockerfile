ARG REGISTRY
ARG TAG
FROM ${REGISTRY}/base-py:${TAG}

############### copy code ###############
ARG MODULE_PATH
COPY $MODULE_PATH /workdir
COPY $MODULE_PATH/legacy_supervisely_lib /workdir/legacy_supervisely_lib
COPY supervisely_lib /workdir/supervisely_lib

ENV PYTHONPATH /workdir:/workdir/src:/workdir/legacy_supervisely_lib/worker_proto:$PYTHONPATH
WORKDIR /workdir/src