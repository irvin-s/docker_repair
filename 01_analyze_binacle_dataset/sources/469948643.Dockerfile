## This is a two-stage docker file
# This first stage has opam & a ton of other things
# inside it. The full image is 1.4Gigs! Which is way
# too big to keep around.
FROM ocaml/opam:alpine as base

RUN sudo apk update
RUN sudo apk add m4
RUN sh -c "cd ~/opam-repository && git pull -q"
RUN opam update
# We'll need these two whatever we're building
RUN opam install dune reason > /dev/null 2>&1

# need these two for building tls, which is needed by cohttp
RUN opam depext conf-gmp.1
RUN opam depext conf-perl.1
RUN opam install tls > /dev/null 2>&1
# these are the dependencies for our server
RUN opam install lwt cohttp cohttp-lwt-unix > /dev/null 2>&1

# Now we copy in the source code which is in the current
# directory, and build it with dune
COPY --chown=opam:nogroup . /hello-reason
WORKDIR /hello-reason
RUN sh -c 'eval `opam config env` dune build bin/Server.exe'

## Here's the second, *much* leaner, stage
# It only contains the server binary! The reason we can do this
# is we statically linked the binary (with -ccopt -static)
FROM scratch
COPY --from=base /hello-reason/_build/default/bin/Server.exe /server
CMD ["/server"]