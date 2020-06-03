# Install nvm  
FROM brownman/bashrc  
  
#FROM brownman/gitlab  
# Run dockerbase script  
ADD . $HOME  
#CMD . $HOME/.bashrc  
#RUN git clone --depth=1 https://github.com/brownman/install_config_test  
#RUN cd install_config_test && chmod u+x travis.sh && ./travis.sh mean  
RUN sudo chmod 755 $HOME/nvm.sh && bash -c $HOME/nvm.sh  

