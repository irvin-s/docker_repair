FROM ocaml/opam:alpine  
MAINTAINER Dmitry Romanov "dmitry.romanov85@gmail.com"  
RUN ["sudo", "apk", "add", "m4"]  
RUN ["sudo", "apk", "add", "lame-dev"]  
  
RUN ["opam", "depext", "-i", "conf-libpcre"]  
RUN ["opam", "install", "liquidsoap"]  
RUN ["opam", "depext", "-i", "lame"]  
RUN ["opam", "depext", "-i", "mad"]  
RUN ["opam", "install", "lastfm"]  
RUN ["opam", "install", "cry"]  
RUN ["opam", "depext", "-i", "taglib"]  
  
VOLUME ["/liquidsoap"]  
WORKDIR /liquidsoap  
  
ENTRYPOINT [ "/home/opam/.opam/4.05.0/bin/liquidsoap" ]  

