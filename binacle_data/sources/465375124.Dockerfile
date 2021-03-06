FROM adamhrv/base:cuda9-cudnn7


# [ Install OpenCV 3.4.1 ]

WORKDIR /opt
RUN git clone https://github.com/opencv/opencv.git && \
  cd opencv && \
  git checkout 3.4.1

RUN cd /opt/opencv && \
  mkdir build && \
  cd build && \
  cmake -D CMAKE_BUILD_TYPE=RELEASE \
    -D CMAKE_INSTALL_PREFIX=/usr/local \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D PYTHON_EXECUTABLE=/usr/bin/python3 \
  -D PYTHON_LIBRARY=/usr/lib/python3.5/config-3.5m-x86_64-linux-gnu/libpython3.5.so \
  -D PYTHON_NUMPY_INCLUDE_DIR=/usr/local/lib/python3.5/dist-packages/numpy/core/include/ \
  -D PYTHON_PACKAGES_PATH=/usr/local/lib/python3.5/dist-packages/ \
    -D WITH_TBB=ON \
    -D WITH_CUDA=OFF \
    -D WITH_V4L=ON \
    -D WITH_QT=OFF \
    -D WITH_OPENGL=OFF \
    -D BUILD_PNG=1 \
    -D BUILD_JPEG=1 \
    -D WITH_FFMPEG=OFF \
    -D BUILD_EXAMPLES=OFF .. && \
  make -j$(nproc) && \
  make install


RUN ln -s /usr/local/lib/python3.5/dist-packages/cv2.cpython-35m-x86_64-linux-gnu.so /usr/local/lib/python3.5/dist-packages/cv2.so


# [ install tensorflow-gpu ]

RUN pip3 install tensorflow-gpu==1.5.0 && \
  pip2.7 install tensorflow-gpu==1.5.0

# [ update sys ]

RUN ldconfig
RUN apt-get update

# [ if end docker node, Startup init ]

ENTRYPOINT /vframe/docker/entrypoint_gpu.sh