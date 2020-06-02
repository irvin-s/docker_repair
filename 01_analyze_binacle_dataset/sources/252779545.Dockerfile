FROM calebzulawski/cotila-base  
  
RUN apt-get -qq update && apt-get -qq install doxygen graphviz zip  

