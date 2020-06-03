FROM rtndocker/rtndfcoretf
RUN apt-get update && apt-get install -y \
    cmake \
    libjpeg8-dev libtiff4-dev libjasper-dev libpng12-dev \
    libgtk2.0-dev \
    libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
    libatlas-base-dev gfortran \
    && rm -rf /var/lib/apt/lists/*
    
RUN pip install numpy

WORKDIR /root/rtndf
RUN git clone https://github.com/opencv/opencv.git
WORKDIR /root/rtndf/opencv
RUN git checkout 3.0.0

WORKDIR /root/rtndf
RUN git clone https://github.com/opencv/opencv_contrib.git
WORKDIR /root/rtndf/opencv_contrib
RUN git checkout 3.0.0

WORKDIR /root/rtndf/opencv
RUN mkdir build
WORKDIR /root/rtndf/opencv/build
RUN cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D INSTALL_C_EXAMPLES=OFF \
	-D INSTALL_PYTHON_EXAMPLES=OFF \
	-D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules \
	-D BUILD_EXAMPLES=OFF ..
	
RUN make -j8
RUN make install
RUN ldconfig






