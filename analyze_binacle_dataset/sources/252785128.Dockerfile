FROM coduno/base  
RUN apt-get update -y && apt-get install -y openjdk-8-jdk  
ADD coduno.yaml /run/coduno.yaml  

