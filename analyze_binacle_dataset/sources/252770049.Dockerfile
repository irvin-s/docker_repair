FROM debian  
MAINTAINER Artur Luiz Oliveira <contato@arturluiz.com>  
  
RUN apt-get update \  
&& apt-get install yui-compressor -y  
  
ENTRYPOINT ['yui-compressor']  

