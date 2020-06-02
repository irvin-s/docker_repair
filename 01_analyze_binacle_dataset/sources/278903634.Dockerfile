# NOTE: this docker file is only for local testing of the build
# it should be copied or symlinked up one directory as docker
# can't go into parent directories
# example of testing a build locally:

# ln -sf requirements/Dockerfile .
# docker build . -t pythonfcl

FROM quay.io/pypa/manylinux1_x86_64:latest


RUN yum install -y gcc 

# install cmake 2.8.12
COPY requirements/install_cmake.bash .
RUN bash install_cmake.bash

# clone FCL and libccd
# the exact checkouts are in clone.bash
COPY requirements/clone.bash .
RUN bash clone.bash

# build and install libccd and fcl using cmake
COPY requirements/build.bash .
RUN bash build.bash

# manylinux includes a bunch of pythons
# to test with others change this env variable
#ENV PATH=/opt/python/cp27-cp27m/bin:$PATH
ENV PATH=/opt/python/cp36-cp36m/bin:$PATH

# we need numpy to build python-fcl
# since we set our path we'll be using the right pip
RUN pip install numpy cython

# build the python-fcl module
COPY . /python_fcl
RUN cd /python_fcl && python setup.py build_ext
