FROM coduno/base  
RUN apt-get update -y && apt-get install groovy -y  
ADD . /run  

