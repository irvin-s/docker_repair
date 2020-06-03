ARG BASE
FROM $BASE

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
# 13 [x] support Docker 17.05 ARG feature
########

ENV CPUCOUNT 1
RUN CPUCOUNT=$(cat /proc/cpuinfo | grep '^processor.*:' | wc -l)

# RUN cd \
#     && wget https://github.com/Itseez/opencv/archive/3.3.0.zip \
#    && unzip 3.3.0.zip

RUN echo "ENV=$HOME/.shrc; export ENV" >~/.profile && \
    echo "export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH" >~/.shrc
