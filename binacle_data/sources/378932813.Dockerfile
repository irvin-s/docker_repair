############################################################
# Dockerfile to build aozan container images
############################################################

# Use Centos 6 as base
FROM centos:6

# File Author / Maintainer
MAINTAINER Laurent Jourdren <jourdren@biologie.ens.fr>

# Install Aozan public version
ADD https://github.com/GenomicParisCentre/aozan/releases/download/v2.2.1/aozan-2.2.1.tar.gz /tmp/

RUN cd /usr/local && \
    tar xzf /tmp/aozan-*.tar.gz && \
    ln -s /usr/local/aozan*/aozan.sh /usr/local/bin && \
    yum install -y java-1.7.0-openjdk.x86_64 \
                   tar \
                   rsync.x86_64 \
                   bzip2.x86_64 \
                   zip.x86_64 \
                   wget.x86_64 && \
    cd /tmp && \
    wget -q http://outils.genomique.biologie.ens.fr/leburon/downloads/illumina/bcl2fastq2-v2.18.0.12-Linux-x86_64.rpm && \
    wget -q ftp://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/2.4.0/ncbi-blast-2.4.0+-2.x86_64.rpm && \
    yum install -y --nogpgcheck localinstall /tmp/bcl2fastq2-*.rpm \
                                             /tmp/ncbi-blast-*.rpm && \
    mkdir -p /aozan_data \
             /aozan_data/var_aozan \
             /aozan_data/conf \
             /aozan_data/log \
             /aozan_data/hiseq \
             /aozan_data/bcl \
             /aozan_data/fastq \
             /aozan_data/runs \
             /aozan_data/casava_samplesheet \
             /aozan_data/aozan_tmp \
             /aozan_data/ressources \
             /aozan_data/ncbi_nt \
             /aozan_data/ressources/genomes \
             /aozan_data/ressources/genomes_descs \
             /aozan_data/ressources/mappers_indexes && \
    rm -rf /tmp/*.rpm /tmp/aozan-*.tar.gz

ENTRYPOINT ["/usr/local/bin/aozan.sh"]
CMD ["-h"]
