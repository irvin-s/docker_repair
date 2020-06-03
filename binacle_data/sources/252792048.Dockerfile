FROM ubuntu:16.04  
ENV DEBIAN_FRONTEND=noninteractive  
RUN apt-get update  
RUN apt-get install curl -y  
RUN apt-get install software-properties-common -y  
RUN add-apt-repository ppa:team-gcc-arm-embedded/ppa  
RUN curl -sL https://deb.nodesource.com/setup_6.x | bash -  
RUN apt-get update  
RUN apt-get install cmake -y  
RUN apt-get install gcc g++ -y  
RUN apt-get install gcc-arm-embedded -y  
RUN apt-get install git -y  
RUN apt-get install vim-common -y # For xxd  
RUN apt-get install gdb -y  
RUN apt-get install nodejs -y  
RUN apt-get install cppcheck -y  

