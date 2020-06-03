FROM coduno/base  
RUN apt-get update -y && apt-get install golang -y  
ADD . /run  

