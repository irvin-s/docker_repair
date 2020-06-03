FROM ubuntu:14.04  
RUN sed -i 's/archive.ubuntu/tw.archive.ubuntu/g' /etc/apt/sources.list  
  
RUN dpkg --add-architecture i386  
RUN apt-get update  
RUN apt-get install -y openjdk-7-jdk  
RUN apt-get install -y build-essential  
RUN apt-get install -y bison g++-multilib git gperf libxml2-utils \  
make python-networkx zlib1g-dev:i386 zip build-essential gcc-multilib  
RUN apt-get install -y curl  
  
RUN mkdir ~/bin  
  
ENV USE_CCACHE 1  
ENV PATH=~/bin:$PATH  
RUN curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo  
RUN chmod a+x ~/bin/repo  

