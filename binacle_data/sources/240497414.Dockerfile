FROM tensorflow/tensorflow:1.12.0
MAINTAINER Akshay Bhat <akshayubhat@gmail.com>
RUN apt-get update -q && apt-get install -y wget xz-utils
WORKDIR "/bin/"
RUN wget https://www.dropbox.com/s/bjyzb8hytdwp2tp/ffmpeg-release-64bit-static.tar.xz
RUN tar xvfJ ffmpeg-release-64bit-static.tar.xz
RUN mv ffmpeg*/* .
WORKDIR "/root/"
RUN apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN apt-get update && apt-get install -y postgresql-client-9.6 zip
RUN apt-get update -q && apt-get install -y pkg-config python-dev python-opencv unzip libopencv-dev python-pip libav-tools libjpeg-dev  libpng-dev  libtiff-dev  libjasper-dev  python-numpy python-scipy  python-pycurl  python-opencv git nginx supervisor libpq-dev python-cffi build-essential libssl-dev libffi-dev python-dev
RUN dpkg -L python-opencv
RUN pip install --upgrade setuptools
RUN pip install --upgrade matplotlib
RUN wget https://yt-dl.org/downloads/latest/youtube-dl -O /bin/youtube-dl
RUN chmod a+rx /bin/youtube-dl
RUN youtube-dl -U
RUN git clone -b stable https://github.com/akshayubhat/DeepVideoAnalytics /root/DVA
WORKDIR "/root/DVA"
RUN pip install --upgrade cffi
RUN pip install --no-deps keras
RUN pip install -r requirements.txt
RUN pip install pip --upgrade
RUN pip install --no-cache-dir http://download.pytorch.org/whl/cpu/torch-0.3.1-cp27-cp27mu-linux_x86_64.whl
RUN pip install --no-cache-dir mxnet==0.11.0
RUN pip install torchvision
RUN apt-get install -y libhdf5-dev
RUN pip install --no-deps h5py
WORKDIR "/root/DVA"
WORKDIR "/root/DVA/repos/lopq/python"
RUN python setup.py install
WORKDIR "/root/DVA/repos/tf_ctpn_cpu/lib/utils/"
RUN ./make.sh
WORKDIR "/root/"
RUN mkdir media
RUN apt-get install -y cmake
RUN mkdir thirdparty
WORKDIR "/root/thirdparty/"
# install dlib
RUN git clone --recursive https://github.com/davisking/dlib
WORKDIR "/root/thirdparty/dlib"
RUN git reset --hard 929c630b381d444bbf5d7aa622e3decc7785ddb2
RUN python setup.py install --yes USE_AVX_INSTRUCTIONS
WORKDIR "/root/thirdparty/"
RUN git clone --recursive https://github.com/facebookresearch/faiss
# install faiss
WORKDIR "/root/thirdparty/faiss"
RUN git reset --hard cdc5a8b7b876fb636362c724f54e06fe889e3ac7
RUN apt-get install -y libopenblas-dev swig
ENV BLASLDFLAGS /usr/lib/libopenblas.so.0
# Replace this with repo version /root/DVA/deploy/dockerfiles/faiss.patch before merging into stable
RUN git apply /root/DVA/deploy/dockerfiles/faiss.patch
RUN ./configure
RUN make -j $(nproc) && make install && make py
#RUN cd tests && ./run_tests.sh && cd ..
ENV PYTHONPATH /root/DVA/repos/:$PYTHONPATH
ENV PYTHONPATH /root/DVA/repos/tf_ctpn_cpu/:$PYTHONPATH
ENV PYTHONPATH /root/thirdparty/faiss/python:$PYTHONPATH
WORKDIR "/root/DVA/server/"
VOLUME ["/root/media","/root/DVA/configs/custom_defaults"]
EXPOSE 80