FROM nachtmaar/androlyze_worker:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

RUN pip install --user flower

# add path for start.sh (second last for git glone init, last for code mounted into container)
ENV PATH=$PATH:$WORK_DIR:$WORK_DIR/docker/flower
ADD . $WORK_DIR

CMD start_flower.sh