FROM ubuntu:trusty
RUN apt-get update && apt-get -y install \
  libirrlicht1.8 \
  libirrlicht-dev \
  g++ \
  git \
  make \
  libx11-dev \
  wget
ADD src /workspace
WORKDIR /workspace
RUN make
CMD make run
