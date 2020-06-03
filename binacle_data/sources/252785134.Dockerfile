FROM coduno/base  
RUN apt-get update -y && apt-get install scala -y  
ADD . /run  

