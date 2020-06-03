FROM avatao/ubuntu:14.04  
# Install common packages  
RUN apt-get -qy update \  
&& apt-get -qy install \  
binwalk \  
gdb \  
hexedit \  
ltrace \  
nasm \  
prelink \  
radare2 \  
strace \  
valgrind \  
yasm \  
\  
libini-config-dev \  
&& apt-get -qy install libini-config-dev:i386 \  
&& ln -sf libini_config.so.3 /usr/lib/x86_64-linux-gnu/libini_config.so \  
&& rm -rf /var/lib/apt/lists/*  
  
COPY . /  
  
# Install 3rd-party software  
RUN pip install setuptools==11.3 \  
&& pip install capstone==3.0.4 \  
&& cd /opt/ROPgadget \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& cd /opt/pwntools \  
&& python setup.py install \  
&& python setup.py clean --all \  
\  
&& cd /opt/preeny \  
&& make CFLAGS=-m32 && mv *-*-* lib32 \  
&& make && mv *-*-* lib64 \  
&& make clean \  
\  
&& chown -R user: /home/user /opt  
  
ENV TERM xterm  

