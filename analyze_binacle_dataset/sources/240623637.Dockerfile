FROM ubuntu:16.04

RUN apt-get update && apt-get install -y automake bison build-essential clang cmake gawk git gperf libtool nasm ninja-build patch python-pyelftools python-capstone texinfo wget 

RUN  useradd -s /bin/bash -m tsxcfi

COPY build /home/tsxcfi/build
COPY patches /home/tsxcfi/patches
COPY src /home/tsxcfi/src
COPY test-suite /home/tsxcfi/test-suite
COPY install.sh clang-tsx clang-tsx-relro switch.sh /home/tsxcfi/

RUN su -c "chown -R tsxcfi:tsxcfi /home/tsxcfi"
RUN su - tsxcfi -c "cd /home/tsxcfi && bash install.sh"
RUN su - tsxcfi -c "echo 'source /home/tsxcfi/switch.sh' >> /home/tsxcfi/.bashrc"

CMD su tsxcfi

