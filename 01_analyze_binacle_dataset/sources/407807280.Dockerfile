FROM thinktopic/cortex-base
# gives us ubuntu 16.10, CUDA, not sure about CUDNNN, lein, vault
MAINTAINER ThinkTopic

RUN apt-get update                                && \
    apt-get install -y -q                            \
    build-essential ant checkinstall cmake pkg-config yasm gfortran git libjpeg-dev libpng-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libv4l-dev libgtk2.0-dev libtbb-dev libatlas-base-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libopencore-amrnb-dev libopencore-amrwb-dev x264 v4l-utils 

RUN curl -L https://github.com/opencv/opencv/archive/3.3.0.tar.gz|tar xvz 
ENV OPENCV_SRC_DIR /opencv-3.3.0

RUN pwd

# change dir to simplify build commands:
WORKDIR ${OPENCV_SRC_DIR}

# so CMake knows to build the Java bindings:
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
# Turned off CUDA support here because it introduced a gcc dependency conflict on my machine and we don't need it for OpenCV
RUN mkdir build && cd build && cmake -D CMAKE_BUILD_TYPE=RELEASE -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_CUDA=OFF ..
RUN cd build && make -j$(nproc)
# Turn the .so into a jar so we can install it to local maven later on using localrepo plugin:
RUN mkdir -p native/linux/x86_64 && cp build/lib/*java*.so native/linux/x86_64/ && jar -cMf opencv-native-330.jar native


ENV DIR /usr/src/app
VOLUME ${DIR}

RUN chmod 777 ${DIR}

# we use the project.clj next to the Dockerfile just to install opencv jars locally, so the
# container runner's app (in DIR) can access them
WORKDIR /

ADD profiles.clj.for-docker-use /etc/leiningen/profiles.clj
ADD install-opencv-jar.sh /install-opencv-jar.sh

ENV LEIN_REPL_HOST "0.0.0.0"
ENV LEIN_REPL_PORT 6666
# this is to do with weirdness around the lein install from the base image
# being specific to the root user
RUN unset LEIN_HOME
RUN unset LEIN_JAR

WORKDIR ${DIR}
ENV HOME ${DIR}
# this will install opencv for the running user, then open a repl
# doing the install inside the dockerfile would make it only work for root
# doing it on run allows for us to run the container as a non superuser
# contrary to my expectations, there's no way of having a system-wide, local maven repo AND a user-specific one
ENTRYPOINT ["bash", "/install-opencv-jar.sh"]


