# ==================================================================
# py27-tf13
# ------------------------------------------------------------------
# python        2.7    (apt)
# tensorflow    1.3.0  (pip)
# pytorch       1.0    (pip)
# ==================================================================

FROM 10.11.3.8:5000/user-images/py2735-pytorch0.4.0
# FROM test:latest

ENV LD_LIBRARY_PATH=/usr/local/cuda/lib64:/lib/x86_64-linux-gnu:/usr/lib/x86_64-linux-gnu:$LD_LIBRARY_PATH PATH=/usr/local/cuda-8.0/bin:$PATH
ENV LC_ALL=C
ENV LANG=en_US.UTF8
ENV LESSCHARSET=UTF-8
ENV PYTHONIOENCODING=UTF-8

RUN	sed -i 's/archive.ubuntu.com/mirrors.ustc.edu.cn/g' /etc/apt/sources.list && \
    rm -rf /var/lib/apt/lists/* \
           /etc/apt/sources.list.d/cuda.list \
           /etc/apt/sources.list.d/nvidia-ml.list && \
	apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        zip \
        unzip

RUN pip2 install deepdish==0.3.6 \
        chainer==3.3.0 \
        pycocotools \
        opendr

# ==================================================================
# tensorflow 1.3.0
# ------------------------------------------------------------------
RUN pip2 uninstall -y tensorflow-gpu
RUN pip2 install tensorflow-gpu==1.3.0 tensorboard 

# ==================================================================
# pytorch 1.0
# ------------------------------------------------------------------
RUN python -m pip uninstall -y torch torchvision
RUN pip2 install torch torchvision 

# neural renderer
# RUN git clone https://github.com/weigq/neural_renderer-1 && \
#     cd neural_renderer-1 && \ 
#     python setup.py install

# ==================================================================
# config & cleanup
# ------------------------------------------------------------------
RUN ldconfig && \
    apt-get clean && \
    apt-get autoremove && \
    rm -rf /var/lib/apt/lists/* /tmp/* ~/*
EXPOSE 6006
