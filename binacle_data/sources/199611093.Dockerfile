############################################################
# Dockerfile to build LibScapi Libs ready for compiling libscapi itself
# Based on scapicryptobiu/libscapi_base
# Tagged: scapicryptobiu/libscapi_libs
############################################################

# Set the base image to libscapi base
FROM scapicryptobiu/libscapi_base

# fetch libscapi and build it
WORKDIR /root
RUN mkdir libscapi
COPY . libscapi/

# build the libs
WORKDIR libscapi
RUN make libs

# publish libscapi and boost artificats
RUN ldconfig ~/boost_1_64_0/stage/lib/ ~/libscapi/install/lib/
