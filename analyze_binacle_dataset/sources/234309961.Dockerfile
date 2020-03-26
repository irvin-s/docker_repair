FROM ocaml/opam:alpine_ocaml-4.06.0

RUN \
  sudo addgroup -S ocaml-libmpdclient && sudo adduser -S -G ocaml-libmpdclient ocaml-libmpdclient

RUN sudo apk update && sudo apk add git m4 mpd mpc ncmpc

RUN \
  echo "ocaml-libmpdclient ALL=(ALL:ALL) NOPASSWD:ALL" | \
    sudo EDITOR=tee visudo -f /etc/sudoers.d/ocaml-libmpdclient

USER ocaml-libmpdclient

COPY . /home/ocaml-libmpdclient/ocaml-libmpdclient
ENV WDIR=/home/ocaml-libmpdclient/ocaml-libmpdclient
ENV TMP=/tmp
ENV U=ocaml-libmpdclient
ENV HOME=/home/ocaml-libmpdclient
COPY . /home/ocaml-libmpdclient/ocaml-libmpdclient
RUN sudo chown -R $U:$U $WDIR
WORKDIR /home/ocaml-libmpdclient/ocaml-libmpdclient
RUN opam init --comp 4.07.0 \
  && opam install lwt cmdliner jbuilder dune odoc ounit bisect_ppx
RUN mkdir -p $TMP/mpd/music && mkdir $TMP/mpd/playlists \
  && cp $WDIR/.travis/mpd.conf $TMP/mpd/mpd.conf \
  && cp $WDIR/.travis/*.mp3 $TMP/mpd/music/ \
  && ls -1 $TMP/mpd/music/ > $TMP/mpd/playlists/bach.m3u \
  && echo $TMP"/mpd/music/kunst01.mp3" > $TMP/mpd/playlists/bach1.m3u \
  && echo ". /home/ocaml-libmpdclient/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true" > $WDIR/runtest.sh \
  && echo "mpd "$TMP"/mpd/mpd.conf" >> $WDIR/runtest.sh \
  && echo "dune runtest --profile release" >> $WDIR/runtest.sh \
  && mpd --version
CMD bash -ex $WDIR/runtest.sh
