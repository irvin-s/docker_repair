FROM nachtmaar/androlyze_base:latest
MAINTAINER Nils Schmidt <schmidt89@informatik.uni-marburg.de>

#####################################################
### Edit passwords here
#####################################################

ENV USER worker

# replace users home directory
ENV HOME /home/$USER/
ENV WORK_DIR $HOME/androlyze/

ENV DIR_CONFIGS /etc/androlyze/
ENV DIR_DATABSE $WORK_DIR/dbs/
ENV DIR_APKS $WORK_DIR/apks/

#####################################################
### Installation
#####################################################

RUN apt-get update \
	&& apt-get install -y --no-install-recommends git python2.7 python-pip gcc python-dev rsync openjdk-7-jre\
	&& apt-get clean

# install python dependencies
COPY requirements.txt /tmp/
RUN pip install -r /tmp/requirements.txt


RUN mkdir -p $WORK_DIR
ADD . $WORK_DIR

# create non-root user
RUN adduser -q --disabled-password --home /home/worker --gecos "" $USER

# set permissions for non-root user
RUN mkdir $DIR_CONFIGS
RUN chown worker:worker -R $DIR_CONFIGS $HOME
RUN chmod 600 -R $DIR_CONFIGS

# change user
USER $USER

WORKDIR $WORK_DIR

# add path for start.sh (second last for git glone init, last for code mounted into container)
ENV PATH=$PATH:$WORK_DIR:$WORK_DIR/docker/worker/
CMD start_worker.sh

VOLUME [$DIR_APKS]
VOLUME [$DIR_DATABASES]
VOLUME [$DIR_CONFIGS]