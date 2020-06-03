FROM why2pac/dp4p:core-{tag}
MAINTAINER Parker <oss@dp.farm>

ARG dp_port=52848

ADD common /data/script/common

RUN echo 'alias dp4p_start="/data/script/common/cmd/start"' >> ~/.bashrc && \
    echo 'alias dp4p_stop="/data/script/common/cmd/stop"' >> ~/.bashrc && \
    echo 'alias dp4p_restart="/data/script/common/cmd/restart"' >> ~/.bashrc && \
    useradd dp4p && \
    chmod +x -R /data/script && \
    /data/script/common/prepare && \
    /data/script/common/node && \
    /data/script/common/cleanup && \
    node --version

EXPOSE $dp_port

