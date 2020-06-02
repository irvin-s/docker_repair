FROM gcr.io/tensorflow/tensorflow:1.0.0-py3

ARG deepspell_dir=/opt/deepspell
ARG deepspell_user=deepspell
ARG deepspell_uid=1000

RUN mkdir -p ${deepspell_dir}

RUN apt-get update && apt-get install -y git

ARG KERAS_VERSION=1.2.2
ENV KERAS_BACKEND=tensorflow
RUN pip3 --no-cache-dir install --no-dependencies git+https://github.com/fchollet/keras.git@${KERAS_VERSION}

RUN pip3 --no-cache-dir install h5py

# dump package lists
RUN dpkg-query -l > /dpkg-query-l.txt \
 && pip3 freeze > /pip3-freeze.txt

# set locale http://jaredmarkell.com/docker-and-locales/
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

ADD / ${deepspell_dir}

RUN useradd -m -s /bin/bash -N -u ${deepspell_uid} ${deepspell_user} && \
    chown ${deepspell_user} ${deepspell_dir} -R

USER ${deepspell_user}

WORKDIR ${deepspell_dir}

CMD /bin/sh /opt/deepspell/run.sh
