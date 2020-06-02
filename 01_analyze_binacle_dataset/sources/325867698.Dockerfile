FROM ufoym/deepo:all-jupyter-py36-cu90


RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    apt install -y openssh-server openssh-client && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*

