FROM alpine:3.8

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      contributor="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.facets_suite="1.5.5" \
      version.facets="0.5.6"\
      version.alpine="3.8" \
      version.r="3.5.0-r1" \
      version.pctGCdata="0.2.0" \
      source.facets_suite="https://github.com/mskcc/facets-suite/releases/tag/1.5.5" \
      source.facets="https://github.com/mskcc/facets/archive/v0.5.6.tar.gz"\
      source.r="https://pkgs.alpinelinux.org/package/edge/community/x86/R"

ENV FACETS_SUITE_VERSION 1.5.5
ENV FACETS_VERSION 0.5.6
ENV R_VERSION 3.5.0-r1
ENV PCTGCDATA 0.2.0

# facets-suite is in a private repo. for now we will just copy from local rather than wget
COPY facets-suite-${FACETS_SUITE_VERSION}.tar.gz /tmp/facets-suite-${FACETS_SUITE_VERSION}.tar.gz

# copy script that installs R packages
COPY install-packages.R /tmp/install-packages.R

RUN apk add --update \
    # for wget
        && apk add ca-certificates openssl wget\
    # for compilation
        && apk add build-base musl-dev python py-pip python-dev \
    # install cairo and R package system dependencies
        && apk add cairo cairo-dev libxt-dev libxml2-dev font-xfree86-type1 \
    # download and install R
        && apk add R=${R_VERSION} R-dev=${R_VERSION} R-doc=${R_VERSION} \
    # download and unzip facets, facets-suite, pctGCdata
        && cd /tmp \
        # download Facets
            && wget https://github.com/mskcc/facets/archive/v${FACETS_VERSION}.tar.gz \
        # download pctGCdata
            && wget https://github.com/mskcc/pctGCdata/archive/v${PCTGCDATA}.tar.gz \
        # unpack Facets
            && tar xvzf v${FACETS_VERSION}.tar.gz \
        # unpack pctGCdata
            && tar xvzf v${PCTGCDATA}.tar.gz \
        # unpack Facets_Suite
            && tar xvzf facets-suite-${FACETS_SUITE_VERSION}.tar.gz \
    # install
        # install pctGCdata
            && cd /tmp/pctGCdata-${PCTGCDATA} \
            && R CMD INSTALL . \
        # install Facets
            && cd /tmp/facets-${FACETS_VERSION} \
            && R CMD INSTALL . \
        # install Facets-Suite R dependencies
            && cd /tmp \
            && Rscript --vanilla install-packages.R \
        # install Facets-Suite
            && cd /tmp/facets-suite-${FACETS_SUITE_VERSION} \
            # correct shebang line
                && sed -i "s/opt\/common\/CentOS_6-dev\/R\/R-3.2.2\//usr\//g" *.R \
            # copy execs to /usr/bin/facets-suite
                && mkdir -p /usr/bin/facets-suite/ \
                && cp /tmp/facets-suite-${FACETS_SUITE_VERSION}/* /usr/bin/facets-suite/ \
    # clean up
        && rm -rf /var/cache/apk/* /tmp/*

ENV PYTHONNOUSERSITE set
ENV FACETS_OVERRIDE_EXITCODE set

ENTRYPOINT ["sh"]
