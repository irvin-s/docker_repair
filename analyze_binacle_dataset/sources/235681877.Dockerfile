FROM ubuntu:xenial
RUN apt-get update && apt-get -y install pandoc python-pygments opam
RUN opam init -ay
RUN opam depext -i -j 4 -vy bos fpath rresult fmt ocamlscript
ENTRYPOINT ["opam","config","exec","--"]
#RUN apt-get -y texlive texlive-xetex texlive-fonts-extra
#COPY * /mnt/
#RUN pandoc -f markdown intro.md -o report.pdf
