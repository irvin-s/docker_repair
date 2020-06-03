FROM kaixhin/cuda-theano:latest
MAINTAINER Karl Ni

RUN apt-get update && apt-get install -y \
  libhdf5-dev \
  python-h5py \
  python-yaml

# Upgrade six
RUN pip install --upgrade six && \
    cd /root && git clone https://github.com/fchollet/keras.git && cd keras && \
    python setup.py install && \
    sudo apt-get -y install vim

RUN pip install ipython && \
    sudo apt-get -y build-dep python-matplotlib
RUN pip install matplotlib
RUN cd /root && \
    wget https://pypi.python.org/packages/source/t/tornado/tornado-4.1.tar.gz && \
    gunzip tornado-4.1.tar.gz && tar -xvf tornado-4.1.tar && \
    cd tornado-4.1 && python setup.py install && \
    pip install notebook && \
    pip install pypng

ADD bootstrap.sh /
RUN chmod a+x bootstrap.sh

# ADD cudnn-7.0-linux-x64-v3.0-prod.tgz /opt
ADD cudnn-7.0-linux-x64-v3.0-prod.tgz /opt
RUN cd /opt/cuda

ENV LD_LIBRARY_PATH=/opt/cuda/lib64:$LD_LIBRARY_PATH
ENV LIBRARY_PATH=/opt/cuda/lib64:$LIBRARY_PATH
ENV CPATH=/opt/cuda/include:$CPATH

EXPOSE 8888

CMD ["jupyter", "notebook", "--no-browser", "--ip='*'"]
