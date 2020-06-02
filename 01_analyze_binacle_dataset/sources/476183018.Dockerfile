# TODO: switch to smaller image?
FROM ocaml/opam2:alpine-3.8-ocaml-4.07 as base

RUN sudo apk update
# perl-utils needed for 'shasum'
RUN sudo apk add m4 perl perl-utils
RUN sudo apk add libressl-dev libffi-dev
RUN sh -c "cd ~/opam-repository && git pull -q"
RUN opam update
# esy deps
RUN opam install dune reason lwt_ppx ppx_let ppx_deriving_yojson cmdliner bos logs \
  re angstrom opam-format ppx_inline_test ppx_sexp_conv opam-state ppx_expect cudf dose3

ENV ESY_VERSION=v0.3.4
RUN git clone -b $ESY_VERSION https://github.com/esy/esy.git
RUN sh -c 'eval `opam config env` cd /home/opam/opam-repository/esy && dune build -j 4'

ENV ESY_SOLVE_CUDF_VERSION=v0.1.8

RUN git clone -b $ESY_SOLVE_CUDF_VERSION https://github.com/andreypopp/esy-solve-cudf.git /home/opam/opam-repository/esy-solve-cudf
# esy-solve-cudf deps
RUN opam install mccs
RUN sh -c 'eval `opam config env` cd /home/opam/opam-repository/esy-solve-cudf && dune build -j 4'

RUN git clone https://github.com/esy-ocaml/FastReplaceString.git /home/opam/opam-repository/fastreplacestring
RUN cd /home/opam/opam-repository/fastreplacestring && make
RUN cp /home/opam/opam-repository/fastreplacestring/bin/fastreplacestring /home/opam/opam-repository/esy/bin/fastreplacestring

RUN mkdir -p /home/opam/opam-repository/esy/_build/default/node_modules/esy-solve-cudf/
RUN cp /home/opam/opam-repository/esy-solve-cudf/_build/default/bin/esySolveCudfCommand.exe /home/opam/opam-repository/esy/_build/default/node_modules/esy-solve-cudf/esySolveCudfCommand.exe

RUN sudo ln -s /home/opam/opam-repository/esy/_build/default/esy/bin/esyCommand.exe /bin/esy
RUN sudo mkdir /data && sudo chown -R opam:nogroup /data
WORKDIR /data
ENTRYPOINT ["esy"]
