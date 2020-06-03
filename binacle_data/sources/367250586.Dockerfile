FROM cudnn:v4

RUN apt-get update
RUN apt-get upgrade -y
# basic tools
RUN apt-get install -y openssh-server git-core curl wget vim-tiny build-essential python-dev python-setuptools

# compilers
RUN apt-get install -y gfortran build-essential make gcc build-essential

# install python
RUN apt-get install -y python2.7 python2.7-dev python-pip

# python-PIL
RUN apt-get install -y python-pil
RUN apt-get install -y python-httplib2 ipython
RUN apt-get install -y python-numpy python-scipy python-pip
RUN apt-get install -y libatlas-dev libatlas3gf-base
RUN apt-get install -y python-skimage python-matplotlib python-pandas
RUN apt-get install -y python-h5py
RUN pip install scikit-learn

# install opencv 2.4.12 
RUN apt-get install -y cmake
RUN apt-get install -y zip
RUN cd ~ && \
    mkdir -p src && \
    cd src && \
    curl -L https://github.com/Itseez/opencv/archive/2.4.12.zip -o ocv.zip && \
    unzip ocv.zip && \
    cd opencv-2.4.12 && \
    mkdir release && \
    cd release && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
          -D CMAKE_INSTALL_PREFIX=/usr/local \
          -D BUILD_PYTHON_SUPPORT=ON \
          .. && \
    make -j8 && \
    make install

RUN sh -c 'echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf'
RUN ldconfig

EXPOSE 8888
