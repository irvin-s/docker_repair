FROM tschaffter/caffe-gpu
MAINTAINER Thomas Schaffter <thomas.schaffter@gmail.com>

RUN yum install -y perl \
	wget \
	ImageMagick

# Install GNU Parallel
RUN wget http://repo.openfusion.net/centos7-x86_64/parallel-20160622-1.of.el7.x86_64.rpm && \
	rpm -Uvh parallel-20160622-1.of.el7.x86_64.rpm && rm -fr parallel-20160622-1.of.el7.x86_64.rpm

WORKDIR /
COPY generate_train_val_sets.py .
COPY generate_image_labels.py .
COPY preprocess.sh .
