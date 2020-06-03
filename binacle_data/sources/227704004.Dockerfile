FROM ubuntu:14.04
MAINTAINER ffedoroff "rfedorov@linkentools.com"

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y curl wget software-properties-common

# Install torch7
WORKDIR /root
RUN curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
RUN git clone https://github.com/torch/distro.git ~/torch --recursive
WORKDIR /root/torch
RUN /root/torch/install.sh

# Install loadcaffe
RUN apt-get install -y libprotobuf-dev protobuf-compiler
RUN /root/torch/install/bin/luarocks install loadcaffe

# Install neural-style
WORKDIR /root
RUN git clone --depth 1 https://github.com/jcjohnson/neural-style.git

# load models (about 500MB)
WORKDIR /root/neural-style
RUN bash models/download_models.sh

RUN ln -s /root/torch/install/bin/th /bin/th

COPY docker-entrypoint.sh /root/
ENTRYPOINT ["/root/docker-entrypoint.sh"]
#CMD ["/cron.sh"]
