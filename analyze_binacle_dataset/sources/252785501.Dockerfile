FROM ocaml/opam:ubuntu-14.04_ocaml-4.04.2  
RUN sudo apt-get install rlwrap && \  
git clone https://github.com/javergar/bondi.git && \  
opam pin add bondi bondi -y && \  
echo 'alias bondi="rlwrap bondi"' >> ~/.bashrc

