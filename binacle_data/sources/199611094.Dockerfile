
############################################################
# Dockerfile to build LibScapi Container Image
# Builds only libscapi itself
# Based on scapicryptobiu/libscapi_libs
# Tagged: scapicryptobiu/libscapi
############################################################

# set the base image to libscapi base
FROM scapicryptobiu/libscapi 

# build GMW
WORKDIR /root/libscapi/protocols/GMW
RUN cmake .
RUN make

# build YaoSingleExecution
WORKDIR /root/libscapi/protocols/YaoSingleExecution
RUN cmake .
RUN make

# build SemiHonestYao/
WORKDIR /root/libscapi/protocols/SemiHonestYao
RUN make

# build MaliciousYao
WORKDIR /root/libscapi/protocols/MaliciousYao
RUN echo start building MaliciousYao library
WORKDIR lib/
RUN make
RUN echo finish building MaliciousYao library
RUN echo start building MaliciousYao apps
WORKDIR ../apps/OfflineP1
RUN make
WORKDIR ../OfflineP2
RUN make
WORKDIR ../OnlineP1
RUN make
WORKDIR ../OnlineP2
RUN make
RUN echo finish building MaliciousYao apps

# done
WORKDIR /root
RUN echo DONE!
