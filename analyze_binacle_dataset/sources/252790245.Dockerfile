FROM alpine  
  
# Install Protoc  
################  
RUN set -ex \  
&& apk \--update --no-cache add \  
bash \  
&& apk \--no-cache add --virtual .pb-build \  
make \  
cmake \  
autoconf \  
automake \  
curl \  
tar \  
libtool \  
g++ \  
git \  
\  
&& mkdir -p /tmp/protobufs \  
&& cd /tmp/protobufs \  
&& git clone https://github.com/google/protobuf.git \  
&& cd protobuf \  
&& ./autogen.sh \  
&& ./configure \--prefix=/usr \  
&& make \  
&& make install \  
&& cd \  
&& rm -rf /tmp/protobufs/ \  
&& apk \--no-cache add libstdc++ \  
&& apk del .pb-build \  
&& rm -rf /var/cache/apk/* \  
&& mkdir /defs  
  
# Setup directories for the volumes that should be used  
WORKDIR /defs  
  
ENTRYPOINT ["protoc"]  

