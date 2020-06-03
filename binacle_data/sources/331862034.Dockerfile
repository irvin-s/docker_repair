# TODO change this to public base.
ARG REGISTRY
ARG TAG
FROM ${REGISTRY}/base-pytorch-v04:${TAG}

ARG MODULE_PATH
COPY $MODULE_PATH /workdir
COPY supervisely_lib /workdir/supervisely_lib

ENV PYTHONPATH /workdir/src:/workdir:/workdir/supervisely_lib/worker_proto:$PYTHONPATH
WORKDIR /workdir/src