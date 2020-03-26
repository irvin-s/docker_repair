ARG REGISTRY
ARG TAG
FROM ${REGISTRY}/base-tensorflow:${TAG}

RUN pip install keras==2.2.4

############### copy code ###############
ARG MODULE_PATH
COPY $MODULE_PATH /workdir
COPY supervisely_lib /workdir/supervisely_lib

ENV PYTHONPATH /workdir:/workdir/src:/workdir/supervisely_lib/worker_proto:$PYTHONPATH
WORKDIR /workdir/src
