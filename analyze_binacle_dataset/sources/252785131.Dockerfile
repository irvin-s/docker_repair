FROM coduno/base  
  
RUN mkdir /node  
RUN apt-get update -y && apt-get install fp-compiler -y  
  
ADD . /run  

