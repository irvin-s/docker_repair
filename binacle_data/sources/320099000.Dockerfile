ARG BASEOS_VER
FROM python:2-$BASEOS_VER

ARG APP_VER

######## changelog
# 01 [x] test new apk adds: docker run --rm -it alpine sh, docker run --rm -it sitkevij/opencv python3 -c 'print("Hello World")'
# 02 [x] linux/auxvec.h: No such file or directory - https://github.com/mirage/mirage-block-unix/issues/45
# 03 [x] alpine-sdk -> build-base
# 04 [ ] migrate @testing to @community
# 05 [x] alpine:3.5 -> alpine:3.6
# 06 [x] python3-dev -> python   
# 07 [x] libjasper -> libjasper-dev
# 08 [ ] use of virtual and/or apk del with edge/testing results in unsatisfiable constraints https://github.com/gliderlabs/docker-alpine/issues/205
# 09 [x] add improved opencv cmake build flags
# 10 [ ] docker run --rm -it sitkevij/opencv python -c "import cv2 print cv2.getBuildInformation()" && /usr/local/bin/opencv_version
# 11 [ ] review Dockerfile against https://github.com/opencv/opencv/blob/master/CMakeLists.txt 
# 12 [ ] Set runtime path of "/usr/local/lib/python2.7/site-packages/cv2.so" to "/usr/local/lib" 
# 13 [x] support Docker 17.05 ARG feature now built as opencv:3.3.0-alpine:3.5
# 14 [x] support -D PYTHON build params, i.e. PYTHON_PACKAGES_PATH=/usr/lib/python2.7/site-packages/ -D PYTHON_PACKAGES_PATH=/usr/local/lib/python2.7/site-packages/ \ https://stackoverflow.com/questions/17287250/install-opencv-for-python-multiple-python-versions
#
# Python 2:
# --     Interpreter:                 /usr/bin/python (ver 2.7.13)
# --     Libraries:                   /usr/lib/libpython2.7.so (ver 2.7.13)
# --     numpy:                       /usr/lib/python2.7/site-packages/numpy/core/include (ver 1.13.3)
# --     packages path:               lib/python2.7/site-packages
########

LABEL org.label-schema.name="opencv" \
      org.label-schema.description="Small OpenCV (Open Source Computer Vision Library) Docker Image for Alpine Linux" \
      org.label-schema.url="https://hub.docker.com/r/sitkevij/opencv/" \
      org.label-schema.usage="https://github.com/sitkevij/opencv/blob/master/README.md" \
      org.label-schema.vcs-url="https://github.com/sitkevij/ffmpeg" \
      org.label-schema.vcs-url="https://github.com/sitkevij/opencv" \
      org.label-schema.vendor="sitkevij" \
      org.label-schema.version="3.3.0" \
      maintainer="https://github.com/sitkevij"

# to exec: docker run --rm sitkevij/opencv sh "~/unit-test.sh"
COPY unit-test.sh ~/

ENV CPUCOUNT 1
RUN CPUCOUNT=`cat /proc/cpuinfo | grep '^processor.*:' | wc -l` && echo "CPUCOUNT=${CPUCOUNT}"

RUN echo -e '@edge http://nl.alpinelinux.org/alpine/edge/main\n@testing http://nl.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories \
  && apk update && apk add ca-certificates && update-ca-certificates \
  && apk upgrade \
  && apk add --no-cache \ 
    openssl \
    build-base \
    linux-headers \ 
    unzip \ 
    wget \ 
    cmake \ 
    # git \ 
    # gnutls \
    # python \
    # python-dev \
    # py-pip \
    # python3-dev \
    libtbb@testing \
    libtbb-dev@testing \
    libjpeg \
    libjpeg-turbo-dev \
    libpng-dev \ 
    tiff-dev \
    libjasper \
    # && pip install --upgrade pip \
    && pip install numpy 
RUN cd \
    && wget https://github.com/Itseez/opencv/archive/${APP_VER}.zip
RUN cd \
    && unzip ${APP_VER}.zip \
    && cd opencv-${APP_VER} \
    && mkdir build \
    && cd build \
    && cmake \ 
        -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D BUILD_opencv_python2=ON \
        # -D BUILD_NEW_PYTHON_SUPPORT=ON \
        # -D PYTHON_EXECUTABLE=/usr/bin/python \
        # -D PYTHON_INCLUDE=/usr/include/python2.7/ \
        # -D PYTHON_LIBRARY=/usr/lib/libpython2.7.so \
        # -D PYTHON_PACKAGES_PATH=/usr/lib/python2.7/site-packages/ \
        # -D PYTHON_NUMPY_INCLUDE_DIRS=/usr/lib/python2.7/site-packages/numpy/core/include/ \
        -D INSTALL_C_EXAMPLES=OFF \
        -D INSTALL_PYTHON_EXAMPLES=OFF \
        -D BUILD_DOCS=OFF \
        -D BUILD_TESTS=OFF \
        -D BUILD_PERF_TESTS=OFF \
        -D WITH_TBB=ON \
        -D WITH_FFMPEG=NO \ 
        -D WITH_IPP=NO \
        -D WITH_OPENEXR=NO \
        ..  \
    && make -j${CPUCOUNT} \
    && make install \
    && cd \
    && rm ${APP_VER}.zip \
    && rm -rf /var/cache/apk/*

# CMD cp /usr/local/lib/python2.7/site-packages/cv2.so /usr/lib/python2.7/site-packages/

CMD cp /root/opencv-3.3.0/build/lib/cv2.so /usr/local/lib/python2.7/site-packages/

# /usr/lib/python2.7/site-packages

ENV PYTHONPATH /usr/local/lib/python2.7/site-packages:$PYTHONPATH