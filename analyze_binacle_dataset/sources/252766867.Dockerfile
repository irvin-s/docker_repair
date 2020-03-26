from debian:stable  
maintainer Alan Zimmerman <alan.zimm@gmail.com>  
  
RUN apt-get update && apt-get install -y \  
libgmp-dev \  
curl \  
git \  
libtinfo-dev \  
libicu-dev  
  
RUN curl -sSL https://get.haskellstack.org/ | sh  
  
ENV LANG C.UTF-8  
ENV LC_ALL C.UTF-8  
ENV LANGUAGE C.UTF-8  
ENV PATH /root/.local/bin:$PATH  
  
RUN stack setup 7.10.3  
RUN stack setup 8.0.1  
RUN stack setup 8.0.2  
RUN stack setup 8.2.1  
RUN stack setup 8.2.2  
RUN stack setup 8.4.1  
  
RUN stack install cabal-install  
RUN cabal update  
RUN stack install alex  
RUN stack install happy  
  
ENV PATH /root/.cabal/bin:$PATH  

