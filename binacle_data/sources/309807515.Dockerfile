ARG BASE_IMAGE=linkernetworks/minimal-notebook:master-cuda90
FROM $BASE_IMAGE

LABEL maintainer="Narumi"

# Install Tensorflow
RUN pip install -U \
    tensorflow-gpu==1.7.1 \
    keras \
    && rm -rf ~/.cache/pip

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
