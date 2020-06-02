FROM duckll/base  
  
MAINTAINER DuckLL <a347liao@gmail.com>  
  
# apt-get  
RUN apt-fast -y install \  
cmake \  
g++-multilib \  
&& apt-fast clean  
##llvm  
WORKDIR /root  
RUN mkdir build \  
&& wget http://llvm.org/releases/3.8.0/llvm-3.8.0.src.tar.xz \  
&& tar xvf llvm-3.8.0.src.tar.xz \  
&& cd llvm-3.8.0.src/tools/ \  
&& wget http://llvm.org/releases/3.8.0/cfe-3.8.0.src.tar.xz \  
&& tar xf cfe-3.8.0.src.tar.xz \  
&& mv cfe-3.8.0.src clang \  
&& cd ../projects \  
&& wget http://llvm.org/releases/3.8.0/compiler-rt-3.8.0.src.tar.xz \  
&& tar xf compiler-rt-3.8.0.src.tar.xz \  
&& mv compiler-rt-3.8.0.src compiler-rt \  
&& cd ../../build \  
&& cmake ../llvm-3.8.0.src \  
&& make \  
&& echo 'export PATH=/root/build/bin/:$PATH' >> /root/.bashrc  

