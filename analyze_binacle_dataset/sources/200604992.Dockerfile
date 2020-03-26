FROM ocaml/opam:ubuntu-16.04_ocaml-4.04.0
MAINTAINER Darin Morrison <freebroccolo@users.noreply.github.com>
USER opam
ENV TERM xterm
ADD . yggdrasil
RUN sudo chown -R opam.nogroup /home/opam/yggdrasil
WORKDIR /home/opam/yggdrasil
RUN make preinstall
RUN opam config exec -- make all
RUN opam config exec -- make test
