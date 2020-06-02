FROM circleci/php:7.1-node-browsers  
  
RUN sudo apt-get update && sudo apt-get install -y \  
libapache2-svn \  
subversion \  
&& sudo rm -rf /var/lib/apt/lists/*  

