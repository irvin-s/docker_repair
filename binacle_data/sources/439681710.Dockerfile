FROM nitnelave/nvidia
MAINTAINER Valentin Tolmer "valentin.tolmer@gmail.com"

RUN ln -s /usr/lib64/libblas.so.3 /usr/lib64/libblas.so && \
    ln -s /usr/lib64/liblapack.so.3 /usr/lib64/liblapack.so

RUN yum -y install \
    freetype-devel \
    gcc-gfortran \
    libjpeg-turbo-devel \
    libpng-devel \
    python-devel \
    python-pip \
    numpy-f2py \
    opencv-python \
    && yum clean all && \
    pip install --no-cache-dir numpy matplotlib cython protobuf && \
    pip install --no-cache-dir scipy && \
    pip install --no-cache-dir scikit-image && \
    for req in $(cat requirements.txt); do pip install --no-cache-dir $req; done

RUN cd / && git clone https://github.com/BVLC/caffe.git && cd caffe && \
    cp Makefile.config.example Makefile.config && \
    echo "USE_CUDNN := 1" >> Makefile.config && \
    sed -i 's/:= atlas/:= open/' Makefile.config && \
    echo "BLAS_INCLUDE := /usr/include/openblas/" >> Makefile.config && \
    echo "BLAS_LIB := /usr/lib64" >> Makefile.config && \
    make -j$(nproc) && \
    make -j$(nproc) pycaffe && \
    ln -s  /caffe/.build_release/tools/caffe /usr/bin/caffe

ENV PYTHONPATH=$PYTHONPATH:/caffe/python
