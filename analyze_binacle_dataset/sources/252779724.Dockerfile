FROM so8cool/swish  
  
MAINTAINER Kacper Sokol <ks1591@bristol.ac.uk>  
  
ENV PROLOG_INTRO_DIR $HOME/prolog_intro  
  
RUN git clone https://github.com/COMS30106/prolog_intro.git $PROLOG_INTRO_DIR  
  
RUN cp -f $PROLOG_INTRO_DIR/* $SWISH_DIR/examples/  

