# ssreflect  
#  
# VERSION 0.0.1  
FROM phusion/baseimage  
MAINTAINER Shohei Yasutake <amutake.s@gmail.com>  
  
ENV COQ_VER 8.4.6  
ENV SSR_VER 1.5.0  
RUN add-apt-repository -y ppa:avsm/ppa  
RUN apt update  
RUN apt install -y git mercurial build-essential wget  
RUN apt install -y ocaml ocaml-native-compilers camlp4-extra opam  
RUN opam init -y  
RUN eval `opam config env`  
RUN echo 'eval `opam config env`' >> /etc/profile  
RUN opam repo add coq-released https://coq.inria.fr/opam/released  
RUN opam install -y coq.${COQ_VER}  
RUN opam install -y coq-ssreflect.${SSR_VER}  

