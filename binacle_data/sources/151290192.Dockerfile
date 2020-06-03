FROM ubuntu:14.04
RUN apt-get -yq update && apt-get -yq upgrade
RUN apt-get -yq install git
RUN apt-get -yq install build-essential libssl-dev pkg-config qt5-qmake qt5-default qtbase5-dev qttools5-dev-tools qtdeclarative5-dev qtdeclarative5-controls-plugin
RUN apt-get -yq install tor # Convert this to a build
WORKDIR /app
# Squash the next few lines when they work
RUN git clone https://github.com/ricochet-im/ricochet.git
WORKDIR /app/ricochet
RUN qmake DEFINES+=RICOCHET_NO_PORTABLE
RUN make
RUN make install
CMD /usr/bin/ricochet
