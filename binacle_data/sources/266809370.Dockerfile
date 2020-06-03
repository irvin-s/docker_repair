FROM openhorizon/cuda-tx1-fullcudnn-opencv

#AUTHOR dima@us.ibm.com
MAINTAINER dyec@us.ibm.com

# this installs darknet: http://pjreddie.com/darknet/install/
# and then configures the tiny model for yolo

RUN apt-get update && apt-get install -y git pkg-config wget

WORKDIR /

RUN git clone https://github.com/pjreddie/darknet.git
WORKDIR /darknet

COPY Makefile /darknet/Makefile

ENV PATH /usr/local/cuda/bin:$PATH
RUN make -j4

RUN wget http://pjreddie.com/media/files/tiny-yolo.weights
RUN wget https://pjreddie.com/media/files/yolo.weights
RUN wget https://pjreddie.com/media/files/tiny-yolo-voc.weights

RUN wget https://pjreddie.com/media/files/yolo-voc.weights

COPY tiny-yolo.cfg /darknet/cfg/tiny-yolo-old.cfg

# now assuming you have an attached webcam (not the itegrated one)
# xhost + && docker run --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm openhorizon/darknet-tx1 ./darknet yolo demo cfg/tiny-yolo.cfg tiny-yolo.weights 
# or to test on one picture (it works even if you don't have X)
# docker run --privileged -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix --rm openhorizon/darknet-tx1 ./darknet yolo test cfg/tiny-yolo.cfg tiny-yolo.weights data/person.jpg
