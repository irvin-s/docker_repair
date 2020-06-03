#######################################################################################
#
# Dockerfile to start a pyGATB/Ptyhon compiling machine using these dependencies:
#
#     -->  gcc 4.9 
#     -->  CMake 3.7.2
#     -->  Python 3.4
#     -->  Cython 0.25.2
#
#   See below to change these values.
#
#--------------------------------------------------------------------------------------
#
# Use:
#
#   For starters, you can look at the docker/build-debian.sh script which builds the
#   the container and runs a pyGATB compilation with it.
#
# ### To build the container, use: 
#
#     docker build -f Dockerfile.debian_compiler -t pygatb/debian_compiler .
#
# ### To run the container.
#
#   Running the container means that you want to compile pyGATB. For that
#   purpose, docker run expects some information, as illustrated in this
#   command:
#
#   docker run -it
#     -v /path/to/py-gatb-source/pyGATB:/mnt/pyGATB    <-- source code
#     -v /path/to/py-gatb-build/:/mnt/pyGATB-build     <-- compiled code
#     -v /path/to/py-gatb-artifacts/:/mnt/artifacts    <-- where lay the egg
#     pygatb/debian_compiler                           <-- container to start
#     build                                            <-- script to run
#     -DCMAKE_CXX_FLAGS_RELEASE="-march=native -Ofast" <-- cmake arguments
#
#   First of all, we have retain that the code is not compiled within the
#   container. Instead we use three external volumes bound to the container using
#   two docker run "-v" arguments. These three volumes simply target:
#
#      1. a directory containing the pyGATB source code, i.e. a "git clone" of
#         pyGATB repository;
#      2. a directory containing the compiled code.
#      3. a directory containing the egg file.
#
#   Using such a design, you can work with an existing clone of pyGATB
#   repository and you can easily access the compiled code.
#
#   pyGATB compiled code directory (hereafter denoted as "py-gatb-build")
#   must also exist on the host system. The container will erase its content
#   content before running the code compiling procedure. (unless a file named
#   keep-build is present in py-gatb-build. Thus, py-gatb-build
#   is passed to docker run as follows:
#
#      -v /full/path/to/py-gatb-build/:/mnt/pyGATB-build
#
#      (do not modify "/mnt/pyGATB-build": this is the mount path within the
#       container. For advanced use it can be altered with
#       -e "PYGATB_BUILD=/mnt/pyGATB-build )
#
#   The compilation can also be ran with a single mount point (easier):
#
#   docker run
#     -v /path/to/py-gatb-source/:/mnt/    <-- parent directory to the source code
#     pygatb/debian_compiler                           <-- container to start
#     build                                            <-- script to run
#     -DCMAKE_CXX_FLAGS_RELEASE="-march=native -Ofast" <-- cmake arguments
#
#   The other directories (pyGATB-build and artifacts) are created in the directory
#   to the source code.
#
#   Sample command from the real life (runs at the root of the repository):
#   docker run --name debian_compiler -it -v "$(realpath ..):/mnt" pygatb/debian_compiler bash
#
# ### Additional notes
# 
#   Root access inside the container:
#
#     - if running: docker exec -it debian_compiler bash
#
#     - if not yet running: docker run --rm -i -t pygatb/debian_compiler bash
#
#######################################################################################

# ###
#     Base commands
#
#     We use a Debian 8 (Jessie) Linux
#
FROM debian:jessie

# who to blame?
LABEL mainteners="Patrick Durand <patrick.durand@inria.fr>; Maël Kerbiriou <mael.kerbiriou@free.fr>"

# ###
#    Configuring gcc and cmake release
#
ENV GCC_VERSION=4.9 \
    CMAKE_SERIES=3.7 \
    CMAKE_VERSION=3.7.2 \
# How many (make) jobs to run in parallel ?
    PARALLEL_OPT="-j4"

# ###
#     Package installation and configuration
#
#     install latest packages of the base system
#     as well as packages required to compile pyGATB
#
RUN echo "APT::Install-Recommends \"false\";\nAPT::Install-Suggests \"false\";" >> /etc/apt/apt.conf \
    && apt-get update && apt-get -y dist-upgrade \
    && apt-get install -y wget make zlib1g-dev \
    && apt-get clean

# ###
#     Compiler installation
#
#     We need a c/c++ compiler in an appropriate release.
#     Note: update-alternatives used by cmake installer (./boostrap)
#           to locate gcc
#
RUN apt-get install -y --no-install-recommends \
    gcc-${GCC_VERSION} g++-${GCC_VERSION} gcc-${GCC_VERSION}-base \
    && update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-${GCC_VERSION} 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-${GCC_VERSION} 100 \
    && apt-get clean

# ###
#     CMAKE installation
#
#     we need cmake in aparticular release; we do not use: apt-get 
#     install cmake since we have to control which version we use.
#     Cmake install procedure: https://cmake.org/install/
#
COPY install-cmake.sh /tmp/
RUN /tmp/install-cmake.sh $CMAKE_VERSION \
 && rm /tmp/install-cmake.sh

# ###
#     Python3 installation
#
#     Python, pip and Cython
#
RUN apt-get install -y python3 python3-dev python3-pip \
    && apt-get clean \
    && pip3 install pytest-runner pytest Cython==0.25.2 --install-option="--no-cython-compile"

# ###
#     Build scripts
#
CMD ["build"]
COPY build.sh /usr/local/bin/build
