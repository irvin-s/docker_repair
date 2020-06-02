FROM archlinux/base

RUN pacman -Syy --noconfirm base-devel boost boost-libs catch2 clang cmake libsodium git python python-pip tar gzip ca-certificates
RUN pip install -q cpp-coveralls
