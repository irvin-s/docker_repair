#FROM ubuntu:16.04
# FROM jfinmetrix/rhadley_ubuntu
FROM ubuntu:trusty
#FROM debian:stretch

#FROM nvidia/cuda:8.0-devel-ubuntu16.04

MAINTAINER Shlomo <shlomo@deep-ml.com>

ENV DEBIAN_FRONTEND noninteractive

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:.


RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# install debian packages
ENV DEBIAN_FRONTEND noninteractive


#Install dependencies
RUN apt-get update && apt-get install --no-install-recommends  -y \
    git cmake build-essential libgoogle-glog-dev libgflags-dev libeigen3-dev libopencv-dev libcppnetlib-dev libboost-dev libboost-iostreams-dev libcurl4-openssl-dev protobuf-compiler libopenblas-dev libhdf5-dev libprotobuf-dev libleveldb-dev libsnappy-dev liblmdb-dev libutfcpp-dev wget unzip supervisor \
    python \
    python-dev \
    python2.7-dev \
    python3-dev \
    python-virtualenv \
    python-wheel \
	python-tk \
    pkg-config \
    # requirements for numpy
    libopenblas-base \
    python-numpy \
    python-scipy \
    # requirements for keras
    python-h5py \
    python-yaml \
    python-pydot \
    python-nose \
	python-h5py \
	python-skimage \
	python-matplotlib \
	python-pandas \
	python-sklearn \
	python-sympy \
	python-joblib \
        build-essential \
        software-properties-common \
        g++ \
        git \
        wget \
        tar \
        git \
        imagemagick \
        curl \
		bc \
		htop\
		curl \
		g++ \
		gfortran \
		git \
		libffi-dev \
		libfreetype6-dev \
		libhdf5-dev \
		libjpeg-dev \
		liblcms2-dev \
		libopenblas-dev \
		liblapack-dev \
		libssl-dev \
		libtiff5-dev \
		libwebp-dev \
		libzmq3-dev \
		nano \
		unzip \
		vim \
		zlib1g-dev \
		qt5-default \
		libvtk6-dev \
		zlib1g-dev \
		libjpeg-dev \
		libwebp-dev \
		libpng-dev \
		libtiff5-dev \
		libjasper-dev \
		libopenexr-dev \
		libgdal-dev \
		libdc1394-22-dev \
		libavcodec-dev \
		libavformat-dev \
		libswscale-dev \
		libtheora-dev \
		libvorbis-dev \
		libxvidcore-dev \
		libx264-dev \
		yasm \
		libopencore-amrnb-dev \
		libopencore-amrwb-dev \
		libv4l-dev \
		libxine2-dev \
		libtbb-dev \
		libeigen3-dev \
		doxygen \
		less \
        htop \
        procps \
        vim-tiny \
        libboost-dev \
        libgraphviz-dev \
		&& \
	apt-get clean && \
	apt-get autoremove && \
	rm -rf /var/lib/apt/lists/* && \
# Link BLAS library to use OpenBLAS using the alternatives mechanism (https://www.scipy.org/scipylib/building/linux.html#debian-ubuntu)
	update-alternatives --set libblas.so.3 /usr/lib/openblas-base/libblas.so.3


RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get install -y --no-install-recommends \
        build-essential \
        clinfo \
        cmake \
        git \
        libboost-all-dev \
        libfftw3-dev \
        libfontconfig1-dev \
        libfreeimage-dev \
        liblapack-dev \
        liblapacke-dev \
        libopenblas-dev \
        ocl-icd-opencl-dev \
        opencl-headers \
        wget \
        xorg-dev && \
rm -rf /var/lib/apt/lists/*


WORKDIR "/root"
WORKDIR /root/
RUN wget https://cmake.org/files/v3.8/cmake-3.8.0-rc4.tar.gz
RUN tar -xvf cmake-3.8.0-rc4.tar.gz
WORKDIR /root/cmake-3.8.0-rc4
RUN /root/cmake-3.8.0-rc4/bootstrap
RUN make
RUN make install

WORKDIR /root

# Build GLFW from source
RUN git clone https://github.com/glfw/glfw.git && \
    cd glfw && \
    mkdir build && \
    cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr .. && \
    make -j4 && \
make install

RUN apt-get install libopenblas-dev libfftw3-dev liblapacke-dev

WORKDIR /root

ENV AF_PATH=/opt/arrayfire AF_DISABLE_GRAPHICS=1
#ARG COMPILE_GRAPHICS=ON

ENV AF_PATH=/opt/arrayfire AF_DISABLE_GRAPHICS=1
#ARG COMPILE_GRAPHICS=OFF

RUN git clone --recursive https://github.com/arrayfire/arrayfire.git -b master && \
    cd arrayfire && mkdir build && cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=/opt/arrayfire-3 \
             -DCMAKE_BUILD_TYPE=Release \
             -DBUILD_CPU=ON \
             -DBUILD_CUDA=OFF \
             -DBUILD_OPENCL=OFF \
             -DBUILD_UNIFIED=ON \
             -DBUILD_GRAPHICS=OFF \
             -DBUILD_NONFREE=OFF \
             -DBUILD_EXAMPLES=ON \
             -DBUILD_TEST=ON \
             -DBUILD_DOCS=OFF \
             -DINSTALL_FORGE_DEV=ON \
             -DUSE_FREEIMAGE_STATIC=OFF && \
             # -DCOMPUTES_DETECTED_LIST="30;35;37;50;52;60" \
    make -j8 && make install && \
    mkdir -p ${AF_PATH} && ln -s /opt/arrayfire-3/* ${AF_PATH}/ && \
    echo "${AF_PATH}/lib" >> /etc/ld.so.conf.d/arrayfire.conf && \
    echo "/usr/local/cuda/nvvm/lib64" >> /etc/ld.so.conf.d/arrayfire.conf && \
ldconfig

#WORKDIR "/root"
#WORKDIR /root/
#RUN wget https://cmake.org/files/v3.8/cmake-3.8.0-rc4.tar.gz
#RUN tar -xvf cmake-3.8.0-rc4.tar.gz
#WORKDIR /root/cmake-3.8.0-rc4
#RUN /root/cmake-3.8.0-rc4/bootstrap
#RUN make
#RUN make install

ENV PATH /usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:.

WORKDIR /root
RUN git clone https://github.com/jpbarrette/curlpp.git
WORKDIR /root/curlpp
RUN cmake .
RUN make install


WORKDIR /root
RUN git clone https://github.com/wjakob/nanogui.git
WORKDIR /root/nanogui
RUN git submodule update --init --recursive
WORKDIR /root/nanogui
RUN cmake .
RUN make

#WORKDIR /root
#RUN git clone https://github.com/glfw/glfw.git
#WORKDIR /root/glfw/
#RUN cmake .
#RUN make
#RUN make install



WORKDIR /root/
RUN git clone https://github.com/ocornut/imgui.git
WORKDIR /root/imgui/examples/opengl2_example/
RUN make
#RUN make install



RUN apt-get update && apt-get install -y software-properties-common && \
    apt-get install -y --no-install-recommends \
        build-essential \
        clinfo \
        git \
        libboost-all-dev \
        libfftw3-dev \
        libfontconfig1-dev \
        libfreeimage-dev \
        liblapack-dev \
        liblapacke-dev \
        libopenblas-dev \
        ocl-icd-opencl-dev \
        opencl-headers \
        wget \
        xorg-dev && \
    rm -rf /var/lib/apt/lists/*

# Setting up symlinks for libcuda and OpenCL ICD
RUN ln -s /usr/local/cuda/lib64/stubs/libcuda.so /usr/lib/libcuda.so.1 && \
    ln -s /usr/lib/libcuda.so.1 /usr/lib/libcuda.so && \
    mkdir -p /etc/OpenCL/vendors && \
    echo "libnvidia-opencl.so.1" > /etc/OpenCL/vendors/nvidia.icd && \
    echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:${PATH}


# Very complicated step, took me hours to make it works. this is required for fastparquet

# Very complicated step, took me hours to make it works. this is required for fastparquet

RUN echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty main \n\
deb-src http://llvm.org/apt/trusty/ llvm-toolchain-trusty main \n\
deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main \n\
deb-src http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.7 main" >> /etc/apt/sources.list

RUN wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add -

RUN apt-get update && apt-get install -y clang-3.7 libclang-common-3.7-dev libclang-3.7-dev libclang1-3.7  libllvm-3.7-ocaml-dev libllvm3.7 lldb-3.7 llvm-3.7 llvm-3.7-dev llvm-3.7-runtime clang-modernize-3.7 clang-format-3.7 lldb-3.7-dev
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN echo "/usr/lib/llvm-3.7/lib/" >> /etc/ld.so.conf && ldconfig


ENV LD_LIBRARY_PATH /usr/lib/llvm-3.7/lib/
ENV LLVM_CONFIG /usr/lib/llvm-3.7/bin/llvm-config

RUN apt-get update -qq \
 && apt-get install --no-install-recommends -y \
    # install python 3
    build-essential \
    clang-3.7 \
    lldb-3.7 \
    llvm-3.7 \
    python-clang-3.7 \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*


RUN echo "deb http://ppa.launchpad.net/keithw/glfw3/ubuntu trusty main" |  tee -a /etc/apt/sources.list.d/fillwave_ext.list
RUN echo "deb-src http://ppa.launchpad.net/keithw/glfw3/ubuntu trusty main" | tee -a /etc/apt/sources.list.d/fillwave_ext.list

RUN apt-get update

RUN apt-get install -qqy --force-yes libglfw3 libglfw3-dev


ENV LD_LIBRARY_PATH $LD_LIBRARY_PATH:/usr/lib/llvm-3.7/lib/:/usr/local/lib/
ENV LIBRARY_PATH $LIBRARY_PATH:$LD_LIBRARY_PATH:/usr/lib/llvm-3.7/lib/:/usr/local/lib/
ENV LLVM_CONFIG /usr/lib/llvm-3.7/bin/llvm-config

WORKDIR /root
RUN git clone https://github.com/vurtun/nuklear.git
WORKDIR /root/nuklear/demo/glfw_opengl2/
RUN make


####################################################PYTHON2########################################################
# Install pip
# pip dependencies


RUN curl --silent https://bootstrap.pypa.io/get-pip.py | python
RUN pip --no-cache-dir install setuptools==33.1.1
# Install other useful Python packages using pip
RUN pip --no-cache-dir install \
		Cython \
		werkzeug pillow psycogreen flask celery redis Boto FileChunkIO nltk fuzzywuzzy rotate-backups oauthlib requests pyOpenSSL ndg-httpsclient pyasn1 \
		path.py \
		Pillow \
		pygments \
		six \
		sphinx \
		wheel \
		zmq



ENV LD_LIBRARY_PATH /usr/lib/llvm-3.7/lib/
ENV LLVM_CONFIG /usr/lib/llvm-3.7/bin/llvm-config

RUN apt-get -qyy install build-essential scons pkg-config libx11-dev libxcursor-dev libxinerama-dev libgl1-mesa-dev libglu-dev libasound2-dev libpulse-dev libfreetype6-dev libssl-dev libudev-dev libxrandr-dev

RUN pip --no-cache-dir install  cython pytest pandas scikit-learn statsmodels  line-profiler psutil spectrum memory_profiler pandas joblib pyparsing pydot pydot-ng graphviz pandoc SQLAlchemy flask toolz cloudpickle python-snappy s3fs widgetsnbextension ipywidgets terminado cytoolz bcolz blosc partd backports.lzma mock cachey moto pandas_datareader
RUN pip install -i https://pypi.anaconda.org/sklam/simple llvmlite
RUN pip --no-cache-dir install fastparquet

# Install Theano and set up Theano config (.theanorc) OpenBLAS
RUN pip --no-cache-dir install theano && \
	\
	echo "[global]\ndevice=cpu\nfloatX=float32\nmode=FAST_RUN \
		\n[lib]\ncnmem=0.95 \
		\n[nvcc]\nfastmath=True \
		\n[blas]\nldflag = -L/usr/lib/openblas-base -lopenblas \
		\n[DebugMode]\ncheck_finite=1" \
	> /root/.theanorc



# Install BAYESIAN FRAMEWORKS
RUN pip --no-cache-dir install  --upgrade pymc3 pystan edward watermark xgboost bokeh seaborn mmh3 tensorflow theano

ENV KERAS_VERSION=1.2.2
ENV KERAS_BACKEND=tensorflow
RUN pip --no-cache-dir install --no-dependencies git+https://github.com/fchollet/keras.git@${KERAS_VERSION}

####################################################PYTHON2########################################################


# configure console
RUN echo 'alias ll="ls --color=auto -lA"' >> /root/.bashrc \
 && echo '"\e[5~": history-search-backward' >> /root/.inputrc \
 && echo '"\e[6~": history-search-forward' >> /root/.inputrc

# RUN which python2.7 /usr/bin/python2.7
RUN ls -la /usr/bin/python2.7

RUN ln -s /opt/python2.7/lib/python2.7/config/libpython2.7.a /usr/local/lib/

ENV LDFLAGS="-L/opt/python2.7/lib:usr/lib/openblas-base/"
ENV PATH /usr/lib/openblas-base/:/usr/lib/openblas-base/bin/:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:.



# Set up notebook config

RUN apt-get -qyy install python2.7 python-pip python-dev ipython ipython-notebook
RUN pip install --upgrade pip
RUN pip install --upgrade ipython
RUN pip --no-cache-dir install jupyter
RUN python -m ipykernel.kernelspec
RUN python2 -m ipykernel.kernelspec --user
RUN jupyter notebook --allow-root --generate-config -y

COPY jupyter_notebook_config.py /root/.jupyter/

# Jupyter has issues with being run directly: https://github.com/ipython/ipython/issues/7062
COPY run_jupyter.sh /root/

WORKDIR "/root/"
RUN chmod +x run_jupyter.sh

RUN jupyter nbextension enable --py --sys-prefix widgetsnbextension

RUN apt-get install software-properties-common
RUN add-apt-repository ppa:george-edison55/cmake-3.x
RUN apt-get update

ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/lib/root


RUN apt-get install -qqy libsasl2-dev libldap2-dev libssl-dev libpq-dev postgresql-9.3 postgresql-client-9.3 postgresql-contrib-9.3
RUN pip install superset pyhive mysqlclient skflow bayesian-optimization scikit-neuralnetwork simplejson ujson bson pyyaml python-ldap superset pyhive psycopg2 SQLAlchemy arrayfire

RUN apt-get -qqy install postgresql postgresql-contrib

#Run pip install http://h2o-release.s3.amazonaws.com/h2o/rel-turing/10/Python/h2o-3.10.0.10-py2.py3-none-any.whl

# Expose Ports for TensorBoard (6006), Ipython (8888) drill
EXPOSE 6006 3838 8787 8888 8786 9786 8788 5432
RUN  apt-get -qqy  install mesa-common-dev freeglut3-dev libglfw-dev libglm-dev libglew1.6-dev xorg-dev libglu1-mesa-dev  libsdl2-dev


USER postgres
# Create a PostgreSQL role named ``docker`` with ``docker`` as the password and
# then create a database `docker` owned by the ``docker`` role.
# Note: here we use ``&&\`` to run commands one after the other - the ``\``
#       allows the RUN command to span multiple lines.
RUN    /etc/init.d/postgresql start &&\
    psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
    createdb -O docker docker

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf


# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

USER root
