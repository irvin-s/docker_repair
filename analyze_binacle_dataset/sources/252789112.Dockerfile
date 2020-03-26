FROM ocaml/opam:alpine_ocaml-4.02.3  
MAINTAINER David Sheets <sheets@alum.mit.edu>  
  
RUN sudo apk update && \  
cd opam-repository && \  
git pull && \  
opam update && \  
opam depext opam-publish && \  
opam install -y opam-publish  
  
RUN git clone https://github.com/dsheets/ocaml-inotify-event.git && \  
cd ocaml-inotify-event && \  
opam pin add -y inotify-event .  

