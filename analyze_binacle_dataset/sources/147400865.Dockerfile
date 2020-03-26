FROM ocaml/opam2

WORKDIR /home/opam/app

COPY . .

RUN sudo chown -R opam:opam .
