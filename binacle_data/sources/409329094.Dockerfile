# This file is read by docker to deploy the SUPERSMART environment
# on a virtual ubuntu host. Provisioning is done by puppet, using the
# 'default.pp' manifest.

# create from image containing phylota database
FROM ubuntu:14.04

# add scripts
ADD default.pp /
ADD intro.sh /

# install necessary packages
RUN apt-get -y update && apt-get install -y puppet nano gzip

# set environment variables required by SUPERSMART
ENV PERL5LIB "$PERL5LIB:/supersmart/lib/"
ENV PATH "$PATH:/supersmart/script/"
ENV PATH "$PATH:/supersmart/tools/bin/"
ENV SUPERSMART_HOME "/supersmart/"
ENV EDITOR "nano"

# this is needed by treePL and beagle to find the libs
ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/lib64"
ENV LD_LIBRARY_PATH "$LD_LIBRARY_PATH:/usr/local/lib"
	
# other environment variables
ENV SHELL "/bin/bash"

# set shared volume to share files with the virtual host
VOLUME [ "/shared" ]

# set directory on startup to shared dir
WORKDIR /shared

# automatically run intro script giving information on startup
RUN echo 'source /intro.sh' >> /root/.bashrc

# provision virtual machine with SUPERSMART environment
RUN puppet apply /default.pp 

# run unit tests 
RUN cd $SUPERSMART_HOME && perl Makefile.PL && make test
