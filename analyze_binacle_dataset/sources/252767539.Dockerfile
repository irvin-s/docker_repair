FROM ubuntu:17.04  
LABEL maintainer="Alexandre Buisine <alexandrejabuisine@gmail.com>"  
LABEL version="1.0.0"  
  
RUN DEBIAN_FRONTEND=noninteractive apt-get -qq update \  
&& apt-get install -yqq \  
git \  
make \  
gcc \  
&& apt-get -yqq clean \  
&& rm -rf /var/lib/apt/lists/*  
  
WORKDIR /tmp  
  
RUN git clone \--depth 1 https://github.com/xlab/netsed.git \  
&& cd netsed \  
&& make \  
&& make install \  
&& rm -r /tmp/netsed  
  
WORKDIR /  
  
ENTRYPOINT ["/usr/local/bin/netsed"]

