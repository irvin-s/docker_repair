FROM alpine:3.5

LABEL maintainer="Jaeyoung Chun (chunj@mskcc.org)" \
      version.image="1.0.0" \
      version.vardict="1.4.6" \
      version.r="3.3.2-r0" \
      version.perl="5.22.3-r0" \
      version.alpine="3.5" \
      source.vardict="https://github.com/AstraZeneca-NGS/VarDictJava/releases/tag/v1.4.6" \
      source.r="https://pkgs.alpinelinux.org/package/v3.5/community/x86_64/R" \
      source.perl="https://pkgs.alpinelinux.org/package/v3.4/main/armhf/perl"

ENV VARDICT_VERSION 1.4.6
ENV R_VERSION 3.3.2-r0
ENV PERL_VERSION 5.24.3-r1

# R only avail in Alpine 3.5 community
RUN apk add --update \
      && apk add ca-certificates openssl bash perl=${PERL_VERSION} \
      && apk add openjdk8-jre-base \
      && apk add R=${R_VERSION} --update-cache --repository http://dl-5.alpinelinux.org/alpine/v3.5/community --allow-untrusted \
      && cd /tmp && wget https://github.com/AstraZeneca-NGS/VarDictJava/releases/download/v${VARDICT_VERSION}/VarDict-${VARDICT_VERSION}.zip \
      && unzip VarDict-${VARDICT_VERSION}.zip \
      && mv /tmp/VarDict-${VARDICT_VERSION} /usr/bin/vardict \
      && rm -rf /var/cache/apk/* /tmp/*

COPY testsomatic.R /usr/bin/vardict/
COPY var2vcf_paired.pl /usr/bin/vardict/

ENTRYPOINT ["/usr/bin/vardict/bin/VarDict"]
