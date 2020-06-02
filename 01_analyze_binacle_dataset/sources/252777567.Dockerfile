FROM debian:jessie  
MAINTAINER Andreas Ntalakas (antalakas@me.com)  
  
RUN apt-get update  
RUN apt-get install -y libzmq3-dev  
RUN apt-get install -y apt-utils  
RUN apt-get install -y wget  
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb  
RUN dpkg -i erlang-solutions_1.0_all.deb  
RUN apt-get update  
RUN apt-get install -y esl-erlang  
RUN apt-get install -y elixir  
RUN rm erlang-solutions_1.0_all.deb  

