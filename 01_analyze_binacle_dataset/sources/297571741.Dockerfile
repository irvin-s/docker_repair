FROM java:8-jdk-alpine

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.seqcna="ver_5.devA" \
      version.r="3.3.2-r0" \
      version.alpine="3.4.6" \
      source.seqcna="https://github.com/soccin/seqCNA/releases/tag/ver_5.devA" \
      source.r="https://pkgs.alpinelinux.org/package/v3.5/community/x86_64/R"

ENV SEQCNA_VERSION ver_5.devA
ENV R_VERSION 3.3.2-r0

# RUN apk add --update \
#       # for wget and bash
#             && apk add ca-certificates openssl bash \
#       # for compilation (R packages)
#             && apk add build-base musl-dev \
#       # install R (only avail in Alpine 3.5 community)
#             && apk add R=${R_VERSION} R-dev=${R_VERSION} R-doc=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
#       # download, unzip, install seqCNA
#             && cd /tmp && wget https://github.com/soccin/seqCNA/archive/${SEQCNA_VERSION}.zip \
#             && unzip ${SEQCNA_VERSION}.zip
#       # install seqCNA dependencies

RUN apk add --update \
      # for wget and bash
            && apk add ca-certificates openssl bash \
      # for compilation (R packages)
            && apk add build-base musl-dev \
      # install R (only avail in Alpine 3.5 community)
            && apk add R=${R_VERSION} R-dev=${R_VERSION} R-doc=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
      # download, unzip, install seqCNA
            && apk add git \
            && cd /tmp && git clone --branch feature/targeted-v5 https://github.com/soccin/seqCNA.git seqCNA-${SEQCNA_VERSION}
      # install seqCNA dependencies

# get Java hooked up with R
RUN R CMD javareconf

COPY install-packages.R /tmp/seqCNA-${SEQCNA_VERSION}/install-packages.R

RUN cd /tmp/seqCNA-${SEQCNA_VERSION} \
            && Rscript --vanilla install-packages.R \
      # copy to /usr/bin/...
            && cp -r /tmp/seqCNA-${SEQCNA_VERSION} /usr/bin/seqCNA/ \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

# hack
RUN sed -i "s|/opt/common/CentOS_6-dev/R/R-3.2.2/bin/Rscript|Rscript|g" /usr/bin/seqCNA/execWrapper.sh
RUN sed -i "s|/opt/common/CentOS_6-dev/R/R-3.2.2/bin/Rscript|Rscript|g" /usr/bin/seqCNA/getGeneCalls
RUN sed -i "s|/opt/common/CentOS_6-dev/R/R-3.2.2/bin/Rscript|Rscript|g" /usr/bin/seqCNA/getPairedCounts
RUN sed -i "s|/opt/common/CentOS_6-dev/R/R-3.2.2/bin/Rscript|Rscript|g" /usr/bin/seqCNA/seqSegment
RUN sed -i "s|/opt/common/CentOS_6-dev/R/R-3.2.2/bin/Rscript|Rscript|g" /usr/bin/seqCNA/testR

# RUN ["Rscript", "--vanilla", "-e", "devtools::install_github('mskcc/pctGCdata')"]

# RUN ["Rscript", "--vanilla", "-e", "source('https://bioconductor.org/biocLite.R'); biocLite(c('IRanges', 'DNAcopy', 'Rsamtools'));"]

ENTRYPOINT ["/usr/bin/seqCNA/seqCNA.sh"]
CMD ["--help"]
