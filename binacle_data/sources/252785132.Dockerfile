FROM coduno/base  
  
RUN mkdir /node  
RUN apt-get update -y && apt-get install php5-cli -y  
  
ADD . /run  

