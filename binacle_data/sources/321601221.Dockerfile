FROM ubuntu:16.04
RUN  dpkg --add-architecture i386 \
  && apt-get update \
  && apt-get install -y --no-install-recommends cmake \
                                                make \
                                                g++-4.9 \
                                                g++-4.9-arm-linux-gnueabihf \
                                                lib32stdc++-4.9-dev \
                                                libc6-dev:i386 \
  && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.9 100 \
                         --slave /usr/bin/g++ g++ /usr/bin/g++-4.9 \
  && update-alternatives --install /usr/bin/arm-linux-gnueabihf-gcc arm-linux-gnueabihf-gcc /usr/bin/arm-linux-gnueabihf-gcc-4.9 100 \
                         --slave /usr/bin/arm-linux-gnueabihf-g++ arm-linux-gnueabihf-g++ /usr/bin/arm-linux-gnueabihf-g++-4.9 \
  && rm -rf /var/lib/apt/lists/*
