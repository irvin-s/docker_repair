FROM ocaml/opam:debian-stable_ocaml-4.03.0  
MAINTAINER Danny Willems "contact@danny-willems.be"  
RUN sudo apt-get update  
  
RUN mkdir workspace  
  
RUN sudo apt-get install -y dialog postgresql ruby-sass  
  
RUN cd opam-repository && git pull && opam update  
  
RUN opam depext conf-libpcre.1  
RUN opam depext conf-openssl.1  
RUN opam depext conf-zlib.1  
RUN opam depext dbm.1.0  
RUN opam depext imagemagick.0.34-1  
RUN opam depext conf-gmp.1  
  
RUN opam install ocsigen-start  
  
# ##### Install node js  
# ##### It is recommended to use volumes to share with your existing node js,  
# ##### cordova and android development installation  
# USER root  
# RUN apt-get install curl  
# RUN curl -sL https://deb.nodesource.com/setup_5.x | bash -  
# RUN apt-get install --yes nodejs  
# ##### Install cordova  
# ##### It is recommended to use volumes to share with your existing node js,  
# ##### cordova and android development installation  
# USER opam  
# RUN sudo npm install -g cordova  

