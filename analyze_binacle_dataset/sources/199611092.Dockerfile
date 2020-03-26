############################################################
# Dockerfile to build LibScapi Container Image
# Builds only libscapi itself
# Based on scapicryptobiu/libscapi_libs
# Tagged: scapicryptobiu/libscapi
############################################################

# set the base image to libscapi base
FROM scapicryptobiu/libscapi_libs

# recopying to invalidate new files
WORKDIR /root
COPY . libscapi/ 

# build libscapi
WORKDIR libscapi
RUN make -f makefile

# build the samples and run one of them
WORKDIR examples
RUN make -f makefile
RUN ./libscapi_example dlog
RUN ./libscapi_example sha1

# done
RUN echo DONE!

