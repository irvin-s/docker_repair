FROM ubuntu:16.04
MAINTAINER Andrew Jesaitis

ENV CACHE_DIR /vep_cache

RUN apt-get update
RUN apt-get install -y git bioperl libmodule-build-perl zlibc zlib1g zlib1g-dev gzip gcc make wget tabix bzip2

RUN cpan App::cpanminus
RUN cpanm PerlIO::gzip File::Copy::Recursive Archive::Extract JSON

RUN git clone https://github.com/Ensembl/ensembl-tools.git --branch release/87 --single-branch

RUN mkdir $CACHE_DIR

WORKDIR /ensembl-tools/scripts/variant_effect_predictor/
RUN perl INSTALL.pl -c $CACHE_DIR
RUN yes | perl INSTALL.pl --AUTO Afc -c $CACHE_DIR --SPECIES homo_sapiens,homo_sapiens_refseq --ASSEMBLY GRCh37
RUN yes | perl INSTALL.pl --AUTO Afc -c $CACHE_DIR --SPECIES homo_sapiens,homo_sapiens_refseq --ASSEMBLY GRCh38
RUN perl convert_cache.pl -d $CACHE_DIR -species all -version all

RUN chmod -R 777 $CACHE_DIR 

WORKDIR /

ENTRYPOINT ["perl", "/ensembl-tools/scripts/variant_effect_predictor/variant_effect_predictor.pl"]
