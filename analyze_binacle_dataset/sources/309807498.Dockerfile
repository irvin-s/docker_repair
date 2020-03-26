ARG BASE_IMAGE=linkernetworks/minimal-notebook:master
FROM $BASE_IMAGE

LABEL maintainer="Narumi"

# Install PyTorch
RUN pip install pip==9.0.3 \
    && pip install \
    http://download.pytorch.org/whl/cpu/torch-0.4.0-cp36-cp36m-linux_x86_64.whl \
    torchvision \
    && rm -rf ~/.cache/pip

ARG CACHE_DATE
ARG SUBMIT_TOOL_NAME=aurora
RUN wget https://raw.githubusercontent.com/linkernetworks/aurora/master/install.sh -O - | bash \
    && if [ "$SUBMIT_TOOL_NAME" != "aurora" ]; then mv /usr/local/bin/aurora /usr/local/bin/$SUBMIT_TOOL_NAME; fi
