FROM coduno/base  
RUN apt-get update -y && apt-get install -y gcc  
ADD coduno.yaml /run/coduno.yaml  

