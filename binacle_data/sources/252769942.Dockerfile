FROM correl/erlang  
MAINTAINER Arthur Burkart <artburkart@gmail.com>  
  
ENV DEBIAN_FRONTEND noninteractive  
ENV CB_VERSION v0.8.15  
# INSTALL CHICAGO BOSS  
RUN git clone https://github.com/ChicagoBoss/ChicagoBoss.git \  
&& cd ChicagoBoss/ \  
&& git checkout tags/$CB_VERSION \  
&& ./rebar get-deps \  
&& ./rebar compile \  
&& make  

