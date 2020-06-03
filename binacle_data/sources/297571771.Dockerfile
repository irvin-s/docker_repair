FROM alpine:3.8

LABEL maintainer="Christopher Allan Bolipata (bolipatc@mskcc.org)" \
      version.image="1.0.0" \
      version.vcf2maf="1.6.16" \
      version.vep="91.3" \
      version.htslib="1.5" \
      version.bcftools="1.5" \
      version.samtools="1.5" \
      version.perl="5.26.2-r1" \
      version.alpine="3.8" \
      source.vcf2maf="https://github.com/mskcc/vcf2maf/releases/tag/v1.6.16" \
      source.vep="http://dec2017.archive.ensembl.org/info/docs/tools/vep/script/vep_download.html#versions" \
      source.htslib="https://github.com/samtools/htslib/releases/tag/1.5" \
      source.bcftools="https://github.com/samtools/bcftools/releases/tag/1.5" \
      source.samtools="https://github.com/samtools/samtools/releases/tag/1.5" \
      source.perl="https://pkgs.alpinelinux.org/package/edge/main/aarch64/perl"

ENV VCF2MAF_VERSION 1.6.16
ENV VEP_VERSION 92
ENV HTSLIB_VERSION 1.5
ENV SAMTOOLS_VERSION 1.5
ENV BCFTOOLS_VERSION 1.5

COPY run.sh /usr/bin/vcf2maf/run.sh

# http://www.ensembl.org/info/docs/tools/vep/script/vep_tutorial.html

RUN apk add --update \
      # install all the build-related tools
            && apk add ca-certificates gcc g++ make git curl curl-dev wget gzip perl perl-dev musl-dev libgcrypt-dev zlib-dev bzip2-dev xz-dev ncurses-dev \
      # install system packages that the Perl modules will need
            && apk add expat-dev libressl-dev perl-net-ssleay mariadb-dev libxml2-dev \
      # install cpanminus
            && curl -L https://cpanmin.us | perl - App::cpanminus \
      # install perl libraries that VEP will need
            && cpanm --notest LWP LWP::Simple LWP::Protocol::https Archive::Extract Archive::Tar Archive::Zip \
            CGI DBI Encode version Time::HiRes DBD::mysql File::Copy::Recursive Perl::OSType Module::Metadata \
            Sereal JSON Bio::Root::Version Set::IntervalTree PerlIO::gzip DBD::mysql \
      # install htslib (for vep)
            && cd /tmp && wget https://github.com/samtools/htslib/releases/download/${HTSLIB_VERSION}/htslib-${HTSLIB_VERSION}.tar.bz2 \
            && tar xvjf htslib-${HTSLIB_VERSION}.tar.bz2 \
            && cd /tmp/htslib-${HTSLIB_VERSION} \
            && ./configure \
            && make && make install \
      # download/unzip vep
            && cd /tmp && wget https://github.com/Ensembl/ensembl-vep/archive/release/${VEP_VERSION}.zip \
            && unzip ${VEP_VERSION} \
      # install vep
            && cd /tmp/ensembl-vep-release-${VEP_VERSION}/ \
            && echo "n" | perl INSTALL.pl --AUTO a 2>&1 | tee install.log \
            && cd /tmp && mv /tmp/ensembl-vep-release-${VEP_VERSION} /usr/bin/vep \
      # install bcftools
            && cd /tmp && wget https://github.com/samtools/bcftools/releases/download/${BCFTOOLS_VERSION}/bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
            && tar xvjf bcftools-${BCFTOOLS_VERSION}.tar.bz2 \
            && cd /tmp/bcftools-${BCFTOOLS_VERSION} \
            && make HTSDIR=/tmp/htslib-${HTSLIB_VERSION} && make install \
      # install samtools
            && cd /tmp && wget https://github.com/samtools/samtools/releases/download/${SAMTOOLS_VERSION}/samtools-${SAMTOOLS_VERSION}.tar.bz2 \
            && tar xvjf samtools-${SAMTOOLS_VERSION}.tar.bz2 \
            && cd /tmp/samtools-${SAMTOOLS_VERSION} \
            && ./configure --with-htslib=/tmp/htslib-${HTSLIB_VERSION} \
            && make && make install \
      # install vcf2maf
            && cd /tmp && wget -O vcf2maf-v${VCF2MAF_VERSION} https://github.com/mskcc/vcf2maf/archive/v${VCF2MAF_VERSION}.zip \
            && unzip vcf2maf-v${VCF2MAF_VERSION} \
            && cp -r vcf2maf-${VCF2MAF_VERSION}/* /usr/bin/vcf2maf/ \
      # clean up
            && rm -rf /var/cache/apk/* /tmp/*

ENTRYPOINT ["sh", "/usr/bin/vcf2maf/run.sh"]
