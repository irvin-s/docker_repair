FROM selenium/node-chrome  
  
ENV PROTRACTOR_VER="^5.0.0"  
ENV NODE_VER=8.11.1  
ENV NODE_BIN=/usr/local/n/versions/node/$NODE_VER/bin  
ENV NODE_LIB=/usr/local/n/versions/node/$NODE_VER/lib/node_modules  
ENV BIN=/usr/local/bin  
  
RUN sudo apt-get update  
RUN sudo apt-get -y install git-all nodejs npm  
RUN sudo npm cache clean -f  
RUN sudo npm install -g n  
RUN sudo n $NODE_VER  
RUN sudo ln -sf $NODE_BIN/node $BIN/node  
RUN sudo npm install -g protractor@$PROTRACTOR_VER  
RUN sudo ln -sf $NODE_BIN/protractor $BIN/protractor  
RUN sudo ln -sf $NODE_BIN/webdriver-manager $BIN/webdriver-manager  
RUN sudo $BIN/webdriver-manager update  

