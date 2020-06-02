FROM coduno/base  
RUN apt-get update -y && apt-get install mono-complete -y  
ADD . /run  

