FROM circleci/openjdk:8-jdk  
  
RUN sudo apt-get -y -qq install python-pip python-dev git && \  
sudo pip install awscli  
  
RUN git clone https://github.com/kamatama41/tfenv.git ~/.tfenv && \  
sudo ln -s ~/.tfenv/bin/* /usr/local/bin

