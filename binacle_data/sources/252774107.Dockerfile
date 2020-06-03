FROM ubuntu:14.04  
MAINTAINER aaron@madlon-kay.com  
  
ENV BIN_HOME=/opt/bin  
ENV MOSES_HOME=$BIN_HOME/moses  
  
WORKDIR $MOSES_HOME  
  
ENV PACKAGES="build-essential \  
git-core \  
pkg-config \  
automake \  
libtool \  
wget \  
zlib1g-dev \  
python-dev \  
libbz2-dev \  
cmake"  
  
RUN apt-get update && apt-get install -q -y ${PACKAGES} python \  
&& git clone --depth 1 https://github.com/moses-smt/mosesdecoder.git \  
&& cd mosesdecoder \  
&& make -f contrib/Makefiles/install-dependencies.gmake PREFIX=/opt \  
&& OPT=/opt ./compile.sh \--prefix=${MOSES_HOME} --install-scripts \  
&& cd \- \  
&& rm -rf mosesdecoder \  
&& git clone --depth 1 https://github.com/moses-smt/mgiza.git \  
&& cd mgiza/mgizapp \  
&& cmake . \  
&& make \  
&& make install \  
&& mkdir -p ${BIN_HOME}/tools \  
&& cp bin/* scripts/merge_alignment.py ${BIN_HOME}/tools \  
&& cd \- \  
&& rm -rf mgiza \  
&& apt-get remove -q -y ${PACKAGES} \  
&& apt-get autoremove -q -y  
  
ENV LD_LIBRARY_PATH /opt/lib  

