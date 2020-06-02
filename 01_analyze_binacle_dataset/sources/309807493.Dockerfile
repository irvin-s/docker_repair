ARG BASE_IMAGE=linkernetworks/minimal-notebook:master
FROM $BASE_IMAGE

LABEL maintainer="Narumi"

RUN apt-get update && \
    apt-get install -y --no-install-recommends graphviz && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Install MXNet and graphviz
RUN pip install -U mxnet==1.1.0 \
    graphviz && \
    rm -rf ~/.cache/pip

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
