FROM brownman/user  
ADD . $HOME  
  
RUN echo 'source $HOME/config.cfg' >> $HOME/.bashrc  
  

