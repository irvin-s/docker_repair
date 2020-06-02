FROM ocaml/opam2

WORKDIR /home/opam/app

COPY . .

RUN sudo chown -R opam:opam .

RUN opam switch 4.05 \
    && eval $(opam env) \
    && opam repository set-url default https://opam.ocaml.org \
    && opam update \
    && opam upgrade -y \
    && opam pin add . --no-action \
    && opam depext --yes --update --install mirage-xmpp \
    && opam depext --yes --update --install mirage \
    && make mirage

EXPOSE 5222

CMD mirage/xmpp --hostname="localhost" -l "info" 2>&1
