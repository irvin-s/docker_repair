FROM bitnami/minideb:jessie


RUN install_packages python python-pip python-numpy
RUN pip install --upgrade pip

RUN pip install enum34 futures mock six && \
    pip install --pre 'protobuf>=3.0.0a3' && \
    pip install -i https://testpypi.python.org/simple --pre grpcio

ADD files/cache.tar.gz /root/
ADD files/serving.tar.gz /

WORKDIR /serving
CMD ["bash"]
