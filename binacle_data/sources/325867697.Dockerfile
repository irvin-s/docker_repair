FROM ufoym/deepo:all-jupyter-py36-cu90


RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt-get update && \
    apt-get install -y openssh-server openssh-client && \
    apt-get clean && \
    apt-get autoremove && \
    pip install opencv-python && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
