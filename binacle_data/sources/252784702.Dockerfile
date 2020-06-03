#############################  
# [BUILDER] #################  
#############################  
  
FROM ubuntu:bionic as builder  
  
RUN buildDeps='ca-certificates \  
build-essential \  
libtinfo-dev \  
zlib1g-dev \  
pkg-config \  
coreutils \  
autoconf \  
git-core \  
automake \  
doxygen \  
libtool \  
cmake \  
bison \  
flex \  
wget \  
perl \  
m4' \  
&& set -ex \  
&& apt-get update -q \  
&& apt-get install -y $buildDeps bc graphviz upx bash python3  
  
RUN echo "===> Install retdec..." \  
&& set -ex \  
&& cd /tmp \  
&& git clone --recursive https://github.com/avast-tl/retdec.git \  
&& cd retdec \  
&& mkdir -p build \  
&& cd build \  
&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr/share/retdec \  
&& make -j `nproc` \  
&& make install  
  
##################  
# [RUNNER] #######  
##################  
  
FROM ubuntu:bionic  
  
LABEL maintainer "https://github.com/blacktop"  
  
RUN groupadd --gid 1000 retdec \  
&& useradd -lm --uid 1000 \--gid 1000 \--home-dir /usr/share/retdec retdec  
  
RUN apt-get update -q \  
&& apt-get install -y bc graphviz upx bash python3 --no-install-recommends \  
&& echo "===> Clean up unnecessary files..." \  
&& apt-get clean \  
&& rm -rf /var/lib/apt/lists/* /var/cache/apt/archives /tmp/* /var/tmp/*  
  
COPY --from=builder /usr/share/retdec /usr/share/retdec  
RUN chown retdec:retdec /usr/share/retdec && du -sh /usr/share/retdec  
  
ENV PATH /usr/share/retdec/bin:$PATH  
  
WORKDIR /samples  
  
USER retdec  
  
ENTRYPOINT ["retdec-decompiler.sh"]  
CMD ["--help"]  

