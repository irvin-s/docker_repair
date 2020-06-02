FROM ubuntu:12.10  
MAINTAINER You You, you@you.com  
RUN sudo apt-get -y install software-properties-common  
RUN sudo add-apt-repository ppa:saltstack/salt  
RUN sudo apt-get update  
# From https://github.com/dotcloud/docker/issues/1024#issuecomment-20018600  
RUN dpkg-divert --local --rename --add /sbin/initctl  
RUN ln -s /bin/true /sbin/initctl  
RUN sudo apt-get -y install salt-minion

