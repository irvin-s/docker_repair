#ifndef DOCKERFILE_BUILD_ESSENTIALS_4_8
#define DOCKERFILE_BUILD_ESSENTIALS_4_8

#// Add the Ubuntu Toolchain PPA.

RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update

#// Install build-essential, but replace compilers with 4.8.
#// http://packages.ubuntu.com/precise/build-essential

RUN apt-get install -y build-essential gcc-4.8 g++-4.8

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-4.8 50
RUN update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-4.8 50

#endif // DOCKERFILE_BUILD_ESSENTIALS_4_8
