FROM python:2.7.15
MAINTAINER @jedichien

# Pick up some TF dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        curl \
        libfreetype6-dev \
        libzmq3-dev \
        pkg-config \
        python2.7-dev \
        rsync \
        software-properties-common \
        unzip \
        libgtk2.0-0 \
        && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*


ADD https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh tmp/Miniconda2-latest-Linux-x86_64.sh
RUN bash tmp/Miniconda2-latest-Linux-x86_64.sh -b

RUN /root/miniconda2/bin/pip install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.8.0-cp27-none-linux_x86_64.whl
RUN /root/miniconda2/bin/pip install opencv-python keras matplotlib Pillow flask eventlet python-socketio pandas scikit-learn

COPY config.py /root/
COPY drive.py /root/
COPY model.py /root/
COPY process_data.py /root/
COPY weights /root/weights

WORKDIR /root

# Flask Server
EXPOSE 4567

ENTRYPOINT ["/root/miniconda2/bin/python", "drive.py"]
