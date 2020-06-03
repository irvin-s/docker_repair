FROM coduno/base  
RUN apt-get update -y && apt-get install -y python3  
ADD coduno.yaml /run/coduno.yaml  

