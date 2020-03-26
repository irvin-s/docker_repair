# This docker file contains build environment  
FROM opensuse/tumbleweed  
MAINTAINER krytin <krytin.vitaly@apriorit.com>  
  
RUN zypper -n update && zypper clean --all  
RUN zypper -n install -t pattern devel_C_C++  
RUN zypper -n install clang llvm-clang-devel llvm-devel cmake libelf-devel \  
kernel-vanilla-devel kernel kernel-devel  
  
RUN zypper -n dup  

