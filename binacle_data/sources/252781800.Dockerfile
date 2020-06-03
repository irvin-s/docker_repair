FROM ocaml/opam:alpine  
  
ENV OPAMYES=1  
RUN sudo apk add --no-cache vim git gcc m4 && \  
opam init && \  
opam install ocamlfind menhir && \  
eval `opam config env` && \  
git clone https://github.com/ChrisLane/Compiler-Construction ~/compiler && \  
cd ~/compiler && \  
git checkout dev && \  
make  
  
WORKDIR /home/opam/compiler  

