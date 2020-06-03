# TODO: switch to smaller image?
FROM ocaml/opam2:alpine-3.8-ocaml-4.07 as base

RUN sudo apk update
RUN sudo apk add m4
RUN sh -c "cd ~/opam-repository && git pull -q"
RUN opam update
# We'll need these two whatever we're building
RUN opam install dune reason 

# need these two for building tls, which is needed by cohttp
RUN opam depext conf-gmp.1
RUN opam depext conf-perl.1
RUN opam install tls
# deps specific to the application
RUN sudo apk add libressl-dev libffi-dev
RUN opam install lwt cohttp cohttp-lwt-unix cohttp-async core async async_ssl uri yojson

COPY --chown=opam:nogroup . /reason-server
WORKDIR /reason-server
RUN sh -c 'eval `opam config env` dune build -j 4 --profile docker'

FROM scratch
COPY --from=base /reason-server/_build/default/executable/ReasonServerApp.exe /server
ENTRYPOINT ["/server"]
