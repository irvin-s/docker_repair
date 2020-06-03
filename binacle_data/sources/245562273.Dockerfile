# By Andrew Alexander | Source at https://github.com/adrw/docker-cs350-os161
FROM debian:7
LABEL Andrew Alexander <me@andrewparadi.com>
# sets up a Docker image according to the instructions on https://www.student.cs.uwaterloo.ca/~build/common/Install161NonCS.html

# preliminary setup
RUN apt-get update && \
      apt-get install build-essential --yes && \
      apt-get install wget --yes && \
      apt-get install libncurses5-dev --yes

# step 1: downloads all of the files listed in the Step 1 table on the instructions page
WORKDIR /root/cs350
RUN bash -c "wget -r -l 1 -nd -nH -A gz --no-check-certificate https://www.student.cs.uwaterloo.ca/~cs350/common/Install161NonCS.html" && \
      for file in $(ls *.tar.gz); do tar -xf $file; done; rm *.tar.gz && \
      apt-get remove wget --yes

# step 2: install binutils for os161
WORKDIR /root/cs350/binutils-2.17+os161-2.0.1
RUN ./configure --nfp --disable-werror --target=mips-harvard-os161 --prefix=/root/sys161/tools && \
      make && \
      make install

# step 3: put sys161 stuff on the PATH
RUN mkdir /root/sys161/bin
ENV PATH /root/sys161/bin:/root/sys161/tools/bin:$PATH
RUN echo "export PATH=$PATH" > $HOME/.bashrc

# step 4: install GCC MIPS cross-compiler
WORKDIR /root/cs350/gcc-4.1.2+os161-2.0
RUN ./configure -nfp --disable-shared --disable-threads --disable-libmudflap --disable-libssp --target=mips-harvard-os161 --prefix=/root/sys161/tools && \
      make && \
      make install

# step 5: install GDB for os161
WORKDIR /root/cs350/gdb-6.6+os161-2.0
RUN ./configure --target=mips-harvard-os161 --prefix=/root/sys161/tools --disable-werror && \
      make && \
      make install

# step 6: install bmake for os161
WORKDIR /root/cs350/bmake
RUN ./boot-strap --prefix=/root/sys161/tools | sed '1,/Commands to install into \/root\/sys161\/tools\//d' | bash

# step 7: set up links for toolchain binaries
RUN mkdir --parents /root/sys161/bin
WORKDIR /root/sys161/tools/bin
RUN bash -c 'for i in mips-*; do ln -s /root/sys161/tools/bin/$i /root/sys161/bin/cs350-`echo $i | cut -d- -f4-`; done' && \
      ln -s /root/sys161/tools/bin/bmake /root/sys161/bin/bmake

# step 8: install sys161
WORKDIR /root/cs350/sys161-1.99.06
RUN ./configure --prefix=/root/sys161 mipseb && \
      make && \
      make install && \
      ln -s /root/sys161/share/examples/sys161/sys161.conf.sample /root/sys161/sys161.conf

# step 9: install os161
# extracting the archive should be done on the host side
VOLUME /root/cs350-os161

# cleanup
RUN bash -c "rm -rf /root/cs350; mkdir -p /root/cs350"

# make sure to start commands in the os161 folder
WORKDIR /root/cs350-os161
