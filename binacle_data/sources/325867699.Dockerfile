FROM ufoym/deepo:py27

RUN sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    apt update && \
    apt install -y openssh-server openssh-client && \
    apt install -y swig && \
    pip install --upgrade pip && \
    pip install opencv-python && \
    pip install easydict && \
    pip install shapely && \
    apt-get clean && \
    apt-get autoremove
