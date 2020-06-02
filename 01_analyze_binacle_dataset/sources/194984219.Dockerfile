FROM opentxs:latest

MAINTAINER Filip Gospodinov "filip@monetas.net"

ENV SOURCE_DIR /home/otuser/opentxs-notary-source
RUN mkdir -p $SOURCE_DIR/build
ADD cmake $SOURCE_DIR/cmake
ADD deps $SOURCE_DIR/deps
ADD scripts $SOURCE_DIR/scripts
ADD tests $SOURCE_DIR/tests
ADD CMakeLists.txt LICENSE .clang-format .gitignore .gitmodules $SOURCE_DIR/
ADD src $SOURCE_DIR/src
ADD .git $SOURCE_DIR/.git
WORKDIR $SOURCE_DIR/build
RUN cmake .. && make -j4 -l2 && make install
