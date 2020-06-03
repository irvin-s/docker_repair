## Starts with the miniscule alpine image, installs R, patches and installs httpuv, adds devtools and cleans up

FROM alpine:edge

MAINTAINER Conor I. Anderson <conor@conr.ca>

RUN apk add --no-cache R R-dev R-doc curl libressl-dev curl-dev libxml2-dev gcc g++ git coreutils bash ncurses

RUN git clone https://github.com/ropensci/git2r.git &&\
  R CMD INSTALL --configure-args="--with-libssl-include=/usr/lib/" git2r &&\
  rm -rf git2r /tmp/*

RUN R -q -e "install.packages(c('devtools', 'covr', 'roxygen2', 'testthat'), repos = 'https://cloud.r-project.org/')" &&\
  rm -rf /tmp/*

CMD ["R"]

