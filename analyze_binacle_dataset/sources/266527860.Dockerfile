FROM openhorizon/aarch64-tx2-cudabase:JetPack3.2-RC

#AUTHOR bmwshop@gmail.com
MAINTAINER nuculur@gmail.com

# this installs darknet: http://pjreddie.com/darknet/install/
# and then configures the tiny model for yolo
RUN apt-get update && apt-get install -y git pkg-config wget

RUN apt-get install -y libopencv-dev
WORKDIR /
RUN git clone https://github.com/pjreddie/darknet.git
WORKDIR /darknet
COPY Makefile /darknet/Makefile

ENV PATH /usr/local/cuda/bin:$PATH
RUN make -j4

RUN wget http://pjreddie.com/media/files/tiny-yolo.weights
RUN wget http://pjreddie.com/media/files/tiny-yolo-voc.weights
RUN wget http://pjreddie.com/media/files/yolo.weights
COPY tiny-yolo.cfg /darknet/cfg/tiny-yolo.cfg

# now assuming you have an attached webcam (not the itegrated one, which is typically cam 0 (/dev/video0))
# xhost + && docker run --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm openhorizon/darknet-tx2 ./darknet detector demo cfg/tiny-yolo-voc.cfg tiny-yolo-voc.weights 
# or to test on one picture (it works even if you don't have X)
# docker run --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm openhorizon/darknet-tx2 ./darknet yolo test cfg/tiny-yolo.cfg tiny-yolo.weights data/person.jpg
