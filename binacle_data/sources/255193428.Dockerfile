FROM tschaffter/caffe-gpu

RUN yum install -y opencv

RUN pip install pydicom \
    matplotlib \
    synapseclient \
    lmdb \
    sklearn

WORKDIR /
COPY deploy_alexnet.prototxt .
COPY solver_alexnet.prototxt .
COPY train_val_alexnet.prototxt .
COPY train.sh . 
