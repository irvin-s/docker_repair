FROM asaaki/elixir-phoenix-dev:0.1.0  
MAINTAINER Christoph Grabo <asaaki@mannaz.cc>  
  
WORKDIR /build  
COPY . /build  
  
CMD ["make", "-f", "package/Makefile"]  

