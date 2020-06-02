FROM mitchtech/rpi-pifm

MAINTAINER Michael J. Mitchell <michael@mitchtech.net>

RUN apt-get update && apt-get install -y -q \
    libsndfile1-dev \
	--no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/ChristopheJacquet/PiFmRds.git && \
    cd PiFmRds/src && \
    make

WORKDIR /PiFmRds

#CMD ["bash"]
CMD ["./src/pi_fm_rds", "-freq", "103.0", "-audio", "./sound.wav", "-rt", "sound_file_text"]
