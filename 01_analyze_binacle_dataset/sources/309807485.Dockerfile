ARG BASE_IMAGE=linkernetworks/minimal-notebook:master-gpu
FROM $BASE_IMAGE

# Install Chainer and CuPy
RUN pip install -U \
    cupy==4.4.0 \
    chainer==3.5.0 \
    && rm -rf ~/.cache/pip

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
