FROM laristra/flecsi-sp:fedora_serial

ARG CC
ARG CXX
ARG CXXFLAGS
ARG BUILD_TYPE
ARG USE_SUBMODULES

#for coverage
ARG CI
ARG TRAVIS
ARG TRAVIS_BRANCH
ARG TRAVIS_JOB_NUMBER
ARG TRAVIS_PULL_REQUEST 
ARG TRAVIS_JOB_ID
ARG TRAVIS_TAG
ARG TRAVIS_REPO_SLUG
ARG TRAVIS_COMMIT

COPY flecsale /home/flecsi/flecsale
USER root
RUN chown -R flecsi:flecsi /home/flecsi/flecsale
USER flecsi

WORKDIR /home/flecsi/flecsale
RUN mkdir build

WORKDIR build
RUN cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
          -DFLECSI_RUNTIME_MODEL=mpi \
          -DENABLE_UNIT_TESTS=ON \
          ..
RUN make -j2 || make VERBOSE=1
RUN make test ARGS="CTEST_OUTPUT_ON_FAILURE=1"
RUN make install DESTDIR=${PWD}

WORKDIR /home/flecsi
