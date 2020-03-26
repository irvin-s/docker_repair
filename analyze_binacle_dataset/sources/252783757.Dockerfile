##  
## binet/slc-dev  
## a Dockerfile to create a container for code development.  
##  
FROM binet/slc-base  
MAINTAINER Sebastien Binet "binet@cern.ch"  
## install useful programs for development  
RUN yum install -y \  
autoconf automake \  
bash-completion \  
binutils-devel bzip2-devel bzip2 \  
file \  
gcc gcc-c++ git glibc-devel glibc-static \  
libtool libXpm-devel libXft-devel libXext-devel \  
m4 make \  
ncurses-devel \  
patch \  
readline readline-devel \  
tar texinfo \  
which  
  
## install go  
RUN curl https://storage.googleapis.com/golang/go1.2.2.linux-amd64.tar.gz | \  
tar -C /usr/local -zxf -  
ENV PATH /usr/local/go/bin:$PATH  
  
## make sure go is correctly installed  
RUN go version  
  
ONBUILD ENV PYTHONSTARTUP $HOME/.pythonrc.py  
ENV PYTHONSTARTUP $HOME/.pythonrc.py  
  
## add files last (as this invalids caches)  
ADD dot-pythonrc.py $HOME/.pythonrc.py  
ADD dot-bashrc $HOME/.bashrc  
  

