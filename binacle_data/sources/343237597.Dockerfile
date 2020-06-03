FROM r-base

RUN apt-get update && \
    apt-get -y install \
        git \
        libssl-dev

# R package dependencies, including a few extras that we'll want handy
RUN install.r \
    crayon \
    docopt \
    drat \
    jsonlite \
    whisker

RUN Rscript -e 'install.packages("https://github.com/richfitz/drat.builder/archive/master.tar.gz", repos = NULL)'

RUN Rscript -e 'drat.builder::install_script("/usr/local/bin")'

WORKDIR /src

ENTRYPOINT ["drat.builder"]
CMD ["--no-build-vignettes", "--no-manual"]
