FROM tensorflow/tensorflow:1.8.0

RUN apt-get update

RUN apt-get install -y \
        build-essential \
        cmake \
        git \
        wget \
        unzip \
        yasm \
        pkg-config \
        libswscale-dev \
        libtbb2 \
        libtbb-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        # libjasper-dev \ this library seems to not be installable at the moment
        libavformat-dev \
        libhdf5-dev \
        libpq-dev

WORKDIR /


RUN apt-get update && apt-get install -y wget && wget https://github.com/opencv/opencv/archive/3.4.1.zip \
    && unzip 3.4.1.zip \
    && mkdir /opencv-3.4.1/cmake_binary \
    && cd /opencv-3.4.1/cmake_binary \
    && cmake -DBUILD_TIFF=ON \
    -DBUILD_opencv_java=OFF \
    -DWITH_CUDA=OFF \
    -DENABLE_AVX=ON \
    -DWITH_OPENGL=ON \
    -DWITH_OPENCL=ON \
    -DWITH_IPP=ON \
    -DWITH_TBB=ON \
    -DWITH_EIGEN=ON \
    -DWITH_V4L=ON \
    -DBUILD_TESTS=OFF \
    -DBUILD_PERF_TESTS=OFF \
    -DCMAKE_BUILD_TYPE=RELEASE \
    -DCMAKE_INSTALL_PREFIX=$(python -c "import sys; print(sys.prefix)") \
    -DPYTHON_EXECUTABLE=$(which python) \
    -DPYTHON_INCLUDE_DIR=$(python -c "from distutils.sysconfig import get_python_inc; print(get_python_inc())") \
    -DPYTHON_PACKAGES_PATH=$(python -c "from distutils.sysconfig import get_python_lib; print(get_python_lib())") .. \
    && make install \
    && rm /3.4.1.zip \
    && rm -r /opencv-3.4.1


RUN apt-get update && apt-get install -y python-pip
RUN pip install grpcio-tools==1.12.0 shortuuid Pillow

RUN mkdir -p /app
RUN apt-get update && apt-get install -y libsm6 libxext6 libgtk2.0-dev
RUN apt-get update && apt-get install -y gimp-plugin-registry
COPY completion/completion-server.py /usr/lib/gimp/2.0/plug-ins/python-eval.py



RUN mkdir -p /app/proto
COPY completion.proto /app/proto
COPY *.py /app/
RUN python -m grpc_tools.protoc -I/app/proto --python_out=/app --grpc_python_out=/app /app/proto/completion.proto

COPY ./entrypoint.sh /
WORKDIR /app
ENTRYPOINT ["/entrypoint.sh"]

