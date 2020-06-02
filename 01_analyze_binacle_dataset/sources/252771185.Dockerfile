  
FROM ubuntu:xenial  
MAINTAINER Guillem Francès guillem.frances@upf.edu  
  
# Set up environment variables  
RUN locale-gen en_US.UTF-8  
ENV LANG=en_US.UTF-8 \  
CXX=g++ \  
HOME=/root \  
BASE_DIR=/root/projects \  
PROBE_URL=https://github.com/aig-upf/probe/archive/master.tar.gz  
  
  
# Install required packages  
RUN apt-get update && apt-get install --no-install-recommends -y \  
build-essential \  
ca-certificates \  
curl \  
scons \  
gcc-multilib \  
flex \  
bison \  
&& rm -rf /var/lib/apt/lists/*  
  
# Create required directories  
RUN mkdir -p $BASE_DIR  
WORKDIR $BASE_DIR  
  
#################################  
# Install & build PROBE  
#################################  
# We build first the FF parser library, then the actual PROBE binary  
RUN curl -SL $PROBE_URL | tar -xz \  
&& mv probe-master probe && cd probe \  
&& cd src/parser-ff && make libff \  
&& cd ../../ && ./build  
  
WORKDIR $BASE_DIR/probe  
CMD ["bash"]  

