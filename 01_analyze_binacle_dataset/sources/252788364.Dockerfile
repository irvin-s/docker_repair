FROM nacyot/lua-lua:apt  
MAINTAINER Cristian Romo "cristian.g.romo@gmail.com"  
RUN apt-get install -y lua5.2-dev  
RUN wget http://luarocks.org/releases/luarocks-2.2.0.tar.gz && \  
tar zxpf luarocks-2.2.0.tar.gz && \  
cd luarocks-2.2.0 && \  
./configure && \  
make bootstrap && \  
cd .. && \  
rm -rf luarocks-2.2.0.tar.gz luarocks-2.2.0  
RUN luarocks install moonscript  
  
#RUN mkdir /source  
WORKDIR /source  
CMD ["bash"]

