FROM debian:jessie  
MAINTAINER Andreas Ntalakas (antalakas@me.com)  
  
RUN apt-get update  
RUN git clone https://github.com/antalakas/dotfiles  
RUN cd dotfiles  
RUN ./setup.sh  
RUN git clone https://github.com/tomasr/molokai  
RUN ln -sf `pwd`/molokai/colors ~/.vim/colors  
RUN git clone https://github.com/powerline/fonts  
RUN cd fonts  
RUN ./install.sh  

