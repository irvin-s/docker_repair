FROM mitchtech/rpi-python

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    dbus \
    fonts-freefont-ttf \
    git \
    libfreetype6 \
    libraspberrypi-dev \
    libsmbclient \
    libssh-4 \
    libssl1.0.0 \
    wget \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget http://omxplayer.sconde.net/builds/omxplayer_0.3.7~git20160206~cb91001_armhf.deb && \
    dpkg -i omxplayer_0.3.7~git20160206~cb91001_armhf.deb && \
    apt-get install -f

RUN git clone git://github.com/adafruit/pi_video_looper.git && \
    cd pi_video_looper && \
    ./install.sh

CMD ["bash"]
