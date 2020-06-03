FROM coduno/base  
RUN apt-get update -y && apt-get install -y g++  
ADD coduno.yaml /run/coduno.yaml  

