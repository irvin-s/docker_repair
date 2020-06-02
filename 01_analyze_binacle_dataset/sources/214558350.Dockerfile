# For fedora21
# Dockerize brainfuck interpreter and compiler 

FROM fedora:21
MAINTAINER Quey-Liang Kao <s101062801@m101.nthu.edu.tw>

# gcc make: for bootstrapping only, to be removed in future releases
# binutils: as and ld is necessary 
RUN yum -y install gcc make binutils git vim

# copy files
COPY . /root/BICIB

# a more comfortable prompt style
COPY etc/.bashrc /root/
RUN make -C /root/BICIB/etc install

# an entry
WORKDIR /root/BICIB/brainfuck
