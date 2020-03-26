FROM nvidia/cuda:7.5-devel

MAINTAINER berlius <berlius52@yahoo.com>

RUN apt-get update && apt-get install -y \
    libglib2.0-dev \
    libgl1-mesa-dev \
    libglu1-mesa-dev \
    libpng12-dev \
    git \
    wget \
    freeglut3-dev \
    libplib-dev \
    libopenal-dev \
    libpng12-dev \
    zlib1g-dev \
    libogg-dev \
    libvorbis-dev \
    g++ \
    libalut-dev \
    libxi-dev \
    libxmu-dev \
    libxrandr-dev \
    make \
    patch \
    xautomation  \
    python-numpy \
    python-scipy  \
    python-dev \
    python-nose \
    python-h5py  \
    libopenblas-dev \
    cmake \
    zlib1g-dev \
    libjpeg-dev \
    xvfb \
    libav-tools \
    xorg-dev \
    python-opengl \
    libboost-all-dev \
    libsdl2-dev \
    swig \
    lxterminal
    
WORKDIR "/root"

RUN wget http://download1438.mediafire.com/iosqat4uz46g/phdfnrsf8n982x4/cudnn-7.5-linux-x64-v5.1.tgz

RUN tar zxvf cudnn-7.5-linux-x64-v5.1.tgz

RUN cp -v /root/cuda/include/cudnn.h /usr/local/cuda/include
RUN cp -v /root/cuda/lib64/lib* /usr/local/cuda/lib64
RUN chmod a+r /usr/local/cuda/include/cudnn.h /usr/local/cuda/lib64/libcudnn*
   
ENV TF_BINARY_URL=https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.11.0rc0-cp27-none-linux_x86_64.whl

RUN apt-get install -y  python-pip
RUN pip install --upgrade $TF_BINARY_URL 
RUN pip install Theano Keras 
 

RUN git clone https://github.com/openai/gym.git && \
    cd gym && \
    pip install -e . && \
    cd ..

RUN git clone https://github.com/ugo-nama-kun/gym_torcs && \
    cd gym_torcs/vtorcs-RL-color && \
    ./configure && \
    make && \
    make install && \
    make datainstall && \
    cd /root

COPY install.sh /root
RUN chmod +x /root/install.sh

WORKDIR "/root/sharedfolder"
CMD ["/bin/bash"]




