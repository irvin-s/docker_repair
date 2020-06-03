FROM nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

MAINTAINER Liam Jones <liam@stardive.co.uk>

# Keep Anaconda download separate so this big layer can usually remain cached
ENV ANACONDA_VERSION=4.2.0
RUN apt-get update && \
    apt-get install --assume-yes \
        ca-certificates \
        curl && \
    curl --location "https://repo.continuum.io/archive/Anaconda3-${ANACONDA_VERSION}-Linux-x86_64.sh" > /anaconda.sh && \
    /bin/bash anaconda.sh -b -p /opt/conda && \
    rm anaconda.sh

ENV PAINTSCHAINER_MODEL=original \
    PAINTSCHAINER_GPU=0 \
    PAINTSCHAINER_S_SIZE=128 \
    TINI_VERSION=0.14.0 \
    DOCKERIZE_VERSION=0.3.0 \
    PATH=/opt/conda/bin:$PATH \
    CFLAGS=-I/usr/local/cuda-8.0/targets/x86_64-linux/include/:$CFLAGS \
    LDFLAGS=-L/usr/local/cuda-8.0/targets/x86_64-linux/lib/:$LDFLAGS \
    LD_LIBRARY_PATH=/usr/local/cuda-8.0/targets/x86_64-linux/lib/:$LD_LIBRARY_PATH

RUN curl --location "https://github.com/liamjones/PaintsChainer-Models/releases/download/{$PAINTSCHAINER_MODEL}/unet_128_standard" > unet_128_standard && \
    curl --location "https://github.com/liamjones/PaintsChainer-Models/releases/download/{$PAINTSCHAINER_MODEL}/unet_512_standard" > unet_512_standard && \
    curl --location "https://github.com/liamjones/PaintsChainer-Models/releases/download/{$PAINTSCHAINER_MODEL}/License.txt" > Licence.txt && \
    curl --location "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" > /usr/local/bin/tini && \
    curl --location "https://github.com/jwilder/dockerize/releases/download/v$DOCKERIZE_VERSION/dockerize-linux-amd64-v$DOCKERIZE_VERSION.tar.gz" > /dockerize.tar.gz && \
    tar -C /usr/local/bin -zxvf /dockerize.tar.gz && \
    rm /dockerize.tar.gz

# Re-running apt-get update because we're hoping to cache the Anaconda layer for a while
RUN mkdir --parents /opt/conda/var/lib/dbus/ & \
    apt-get update && \
    apt-get install --assume-yes \
        cron \
        git \
        libgtk2.0-0 \
        libpng12-0 \
        tmpreaper && \
    apt-get clean && \
    rm --recursive --force /var/lib/apt/lists/* && \
    chmod +x /usr/local/bin/tini && \
    conda install --yes --channel menpo opencv3 && \
    conda clean --all && \
    pip --no-cache-dir install \
        cupy \
        chainer

ENV PAINTSCHAINER_REPO=https://github.com/pfnet/PaintsChainer.git \
    PAINTSCHAINER_COMMIT=1c14f9e

RUN git clone $PAINTSCHAINER_REPO && \
    mkdir /PaintsChainer/cgi-bin/paint_x2_unet/models/ && \
    mv /unet_*_standard /Licence.txt /PaintsChainer/cgi-bin/paint_x2_unet/models/ && \
    touch /PaintsChainer/images/line/.tmpreaper && \
    touch /PaintsChainer/images/out/.tmpreaper && \
    touch /PaintsChainer/images/out_min/.tmpreaper && \
    touch /PaintsChainer/images/ref/.tmpreaper && \
    /bin/bash -c "echo -e \"* * * * * root /usr/sbin/tmpreaper --protect '*/.tmpreaper' 1h /PaintsChainer/images/\n\" > /etc/cron.d/delete-old-paintschainer-images" && \
    chmod 0644 /etc/cron.d/delete-old-paintschainer-images

WORKDIR /PaintsChainer

COPY *.patch ./

RUN git checkout $PAINTSCHAINER_COMMIT && \
    git apply *.patch && \
    rm *.patch && \
    mv server.py server.py.template

EXPOSE 8000

ENTRYPOINT [ "tini", "-g", "--" ]

CMD [ "sh", "-c", "cron && dockerize --template server.py.template:server.py && python -u server.py --host 0.0.0.0 --gpu $PAINTSCHAINER_GPU"]
