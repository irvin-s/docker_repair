FROM brownman/rbenv  
  
#USER $USER1  
#ENV HOME /home/$USER1  
RUN rbenv install 2.1.0 && rbenv global 2.1.0  
  
# Install Bundler for each version of ruby  
RUN echo 'gem: --no-rdoc --no-ri' >> $HOME/.gemrc  
RUN gem install bundler  

