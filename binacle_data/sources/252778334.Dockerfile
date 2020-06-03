FROM debian:stretch-slim  
  
ENV _examples=/examples \  
_build=/qmk_firmware  
  
RUN apt-get update -qy\  
&& apt-get install -qy git make build-essential \  
&& git clone https://github.com/qmk/qmk_firmware.git \  
&& cd $_build \  
&& util/install_dependencies.sh \  
&& make git-submodule \  
&& apt-get remove -y git \  
&& apt-get -y autoremove \  
&& rm -r /var/lib/apt/lists/*  
  
COPY bin/*.c $_examples/  
COPY bin/runme.sh /usr/bin  
  
WORKDIR $_build  
  
ENTRYPOINT [ "runme.sh" ]  

