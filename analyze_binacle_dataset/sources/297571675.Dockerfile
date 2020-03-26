FROM alpine:3.6

LABEL maintainer="Nikhil Kumar (kumarn1@mskcc.org)" \
      contributor="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.ngsfilters="1.2" \
      version.r="3.3.3-r0" \
      version.alpine="3.6" \
      source.ngsfilters="https://github.com/mskcc/ngs-filters/releases/tag/v1.2" \
      source.r="https://pkgs.alpinelinux.org/package/v3.5/community/x86_64/R"

ENV NGS_FILTERS_VERSION 1.2
ENV R_VERSION 3.3.3-r0

RUN apk add --update \
      # for wget and bash
            && apk add ca-certificates openssl bash \
      # for compilation (R packages)
            && apk add build-base musl-dev python py-pip python-dev\
      # install R (only avail in Alpine 3.5 community)
            && apk add R=${R_VERSION} R-dev=${R_VERSION} R-doc=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
      # download, unzip, install ngs-filters
            && cd /tmp && wget https://github.com/mskcc/ngs-filters/archive/v${NGS_FILTERS_VERSION}.zip \
            && unzip v${NGS_FILTERS_VERSION}.zip \
      # install ngs-filters dependencies
            && cd /tmp/ngs-filters-${NGS_FILTERS_VERSION} \
            && Rscript --vanilla install-packages.R \
            && pip install -r requirements.txt \
            && apk add --update util-linux \
      # copy to /usr/bin/...
            && cp -r /tmp/ngs-filters-${NGS_FILTERS_VERSION} /usr/bin/ngs-filters/ \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

# copy .git-commit-hash to the ngs-filters directory
COPY .git-commit-hash /usr/bin/ngs-filters/

# disable per-user site-packages
ENV PYTHONNOUSERSITE set

ENTRYPOINT ["python", "/usr/bin/ngs-filters/run_ngs-filters.py"]
CMD ["--help"]
