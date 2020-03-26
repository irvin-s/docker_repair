#
# TODO -- don't use bd4c/baseimage
# (using for now so I don't have to think)
#
FROM       radial/busyboxplus:git
MAINTAINER Flip Kromer <flip@infochimps.com>, Russell Jurney

ENV  CODE_REPO https://github.com/mrflip/big_data_for_chimps-code.git
ENV  BOOK_REPO https://github.com/infochimps-labs/big_data_for_chimps.git
ENV  USER      chimpy

COPY setup-homedir.sh /tmp/
RUN  /tmp/setup-homedir.sh

# ENTRYPOINT ["/bin/bash"]
