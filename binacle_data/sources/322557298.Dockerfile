FROM ubuntu:16.04

RUN apt-get update && apt-get install -y \
    build-essential \
    sed \
    sudo \
    tar \
    udev \
    wget \
    git \
    nano \
    python-pip \ 
    python-dev \ 
    build-essential \ 
    && apt-get clean

RUN pip install --upgrade cython


WORKDIR "/workspace"
# ncsdk api install
RUN git clone -b ncsdk2 https://github.com/movidius/ncsdk.git 
RUN cd ncsdk && make install && ./install-opencv.sh
RUN /bin/bash -c "source ~/.bashrc"
# Yolo install
RUN git clone https://github.com/fernandodelacalle/yolo-darkflow-movidius.git
WORKDIR "/workspace/yolo-darkflow-movidius"
RUN git clone https://github.com/thtrieu/darkflow darkflow_all
RUN cd darkflow_all && \
    python3 setup.py build_ext --inplace && \
    pip install -e .
RUN cd darkflow_all && \
    wget -O tiny-yolo-voc.cfg https://raw.githubusercontent.com/pjreddie/darknet/master/cfg/yolov2-tiny-voc.cfg  && \
    wget -O tiny-yolo-voc.weights https://pjreddie.com/media/files/yolov2-tiny-voc.weights && \
    python3 flow --model tiny-yolo-voc.cfg --load tiny-yolo-voc.weights --savepb  || echo "DONE"
RUN ln -s darkflow_all/darkflow darkflow && \
    mv darkflow_all/built_graph/ . 
RUN export PYTHONPATH="${PYTHONPATH}:/opt/movidius/caffe/python" && \
    mvNCCompile built_graph/tiny-yolo-voc.pb -s 12 -in input -on output -o built_graph/tiny-yolo-voc.graph

RUN pip3 install flask
CMD [ "python3", "main.py" ]