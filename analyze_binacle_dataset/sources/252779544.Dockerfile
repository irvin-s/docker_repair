FROM calebzulawski/cotila-base  
  
RUN apt-get -qq update && apt-get -qq install clang  
  
ENV CC=clang CXX=clang++  

