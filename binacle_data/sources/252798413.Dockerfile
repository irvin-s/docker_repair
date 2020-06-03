FROM hubbitus/latex  
MAINTAINER Dênis Volpato Martins <denisvm@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
make git python3 python3-pip \  
&& pip3 --no-cache-dir install sphinx \  
&& rm -rf /var/lib/apt/lists/*  

