FROM magland/ubuntu-qt5-nodejs

RUN apt-get install -y libfftw3-dev

RUN apt-get install -y octave

RUN apt-get install -y git nano htop

RUN git clone --branch master https://github.com/magland/mountainlab

WORKDIR mountainlab

RUN ./compile_components.sh prv mountainprocess mountainsort mdaconvert

ENV PATH="/mountainlab/bin:${PATH}"


