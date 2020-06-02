ARG BASE_IMAGE_TAG=6f7c91da63bfc40db882b1056ece52e7c7dc5c00
ARG BASE_IMAGE=atom-base
FROM elementaryrobotics/$BASE_IMAGE:$BASE_IMAGE_TAG

# Want to copy over the contents of this repo to the code
#	section so that we have the source
ADD . /atom

#
# Build and install the python library
#
WORKDIR /atom/languages/python
RUN pip3 install -r requirements.txt
RUN python3 setup.py install

#
# Build and install the c library
#

# Need to first build hiredis
WORKDIR /atom/languages/c/third-party/hiredis
RUN make clean && make && make install LIBRARY_PATH=lib

# And build the C library
WORKDIR /atom/languages/c
RUN make clean && make && make install

#
# Build and install the c++ library
#

WORKDIR /atom/languages/cpp
RUN make clean && make && make install

#
# And finally set up the LD_LIBRARY_PATH on the system s.t.
#   our binaries work as expected
ENV LD_LIBRARY_PATH /usr/local/lib:${LD_LIBRARY_PATH}

#
# Install dependencies for atom-cli
#
WORKDIR /atom/utilities/atom-cli
RUN pip3 install -r requirements.txt
RUN cp atom-cli.py /usr/bin/atom-cli
RUN chmod +x /usr/bin/atom-cli

# Change working directory back to atom location
WORKDIR /atom
