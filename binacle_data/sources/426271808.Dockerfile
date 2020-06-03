FROM rocker/ropensci

RUN apt-get update \
    && apt-get install -y \
       libopenmpi-dev \
       libzmq3-dev

RUN Rscript -e "install.packages(c('littler', 'docopt'), repo = 'https://cloud.r-project.org', lib='/usr/local/lib/R/site-library')" 

## Legacy (snow is deprecated)
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error snow doSNOW 

## MPI
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error Rmpi

## Random Number Generation (RNG)
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error rlecuyer

## The foreach ecosystem
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error foreach iterators
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error doParallel doMC doRNG

## The future ecosystem
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error future future.apply doFuture future.callr furrr

RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error BatchJobs future.BatchJobs   ## heavy set of dependencies
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error batchtools future.batchtools ## heavy set of dependencies
RUN /usr/local/lib/R/site-library/littler/examples/install2.r --error clustermq                    ## heavy set of dependencies

RUN echo "www-frame-origin=same" >> /etc/rstudio/disable_auth_rserver.conf

EXPOSE 8787

ARG NB_USER="rstudio"
ARG NB_UID="1000"
ARG NB_GID="100"
ENV PATH=$PATH:/usr/local/bin/:/usr/lib/rstudio-server/bin/

USER root
COPY start.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/start.sh

CMD ["/usr/local/bin/start.sh", "/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--auth-none=1", "--auth-validate-users=0", "--www-frame-origin=same"]
