# This is a Dockerfile of the Aalto Speech Diarizer.
# To install using this Dockerfile:
#   docker build . -t speech-diarizer
#
# To run:
#   docker run -it blabbertabber/aalto-speech-diarizer bash
#   cd /speaker-diarization
#   curl -k -OL https://nono.io/meeting.wav  # sample .wav; substitute yours
#   ./spk-diarization2.py meeting.wav        # substitute your .wav filename
#   cat stdout                               # browse output


FROM fedora

LABEL authors="Brian Cunnie <brian.cunnie@gmail.com>, Brendan Cunnie <saintbrendan@gmail.com>, Tran Tu <trand.tu@gmail.com>"

# for converting audio files to wav
RUN dnf install -y https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
RUN dnf install -y ffmpeg

# required development tools
RUN dnf groupinstall -y "Development Tools"; \
    dnf install -y https://kojipkgs.fedoraproject.org//packages/cmake/2.8.12.2/2.fc21/x86_64/cmake-2.8.12.2-2.fc21.x86_64.rpm \
        SDL-devel \
        python-devel \
        lapack-devel \
        libsndfile-devel \
        fftw-devel \
        clang \
        clang-devel \
        swig \
        gcc-c++

# Aalto-speech pre-req
RUN git clone https://github.com/aalto-speech/AaltoASR.git; \
    cd AaltoASR; \
    mkdir build; \
    cd build; \
    cmake .. ; \
    make; \
    make install

# The diarizer proper
RUN git clone https://github.com/aalto-speech/speaker-diarization.git; \
    cd /speaker-diarization; \
    ln -s ../AaltoASR ./ ; \
    ln -s ../AaltoASR/build ./ ; \
    ln -s ../AaltoASR/build/aku/feacat ./ ; \
    pip install numpy scipy docopt
