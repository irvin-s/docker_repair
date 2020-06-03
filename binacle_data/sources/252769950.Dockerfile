FROM ubuntu:14.04  
MAINTAINER Jose L. Navarro <jlnavarro111@gmail.com>  
  
# install required packages  
RUN apt-get update && apt-get install -y \  
wget \  
make \  
gcc \  
libc6-dev \  
libncurses5-dev \  
libssl-dev \  
libexpat1-dev \  
libpam0g-dev  
  
# add esl packages  
RUN wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb \  
&& dpkg -i erlang-solutions_1.0_all.deb \  
&& wget http://packages.erlang-solutions.com/debian/erlang_solutions.asc\  
&& apt-key add erlang_solutions.asc \  
&& apt-get update \  
&& apt-get install -y \  
erlang=1:18.1 erlang-base-hipe=1:18.1 erlang-dev=1:18.1  
# Define default command.  
CMD ["bash"]

