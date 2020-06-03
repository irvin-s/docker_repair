FROM python:2.7

# Initial update
RUN DEBIAN_FRONTEND=noninteractive apt-get clean && apt-get update && apt-get dist-upgrade -y
# add apt-add-repository
#RUN DEBIAN_FRONTEND=noninteractive apt-get install -y \
#  python-software-properties \
#  software-properties-common

# Add repository for R
RUN DEBIAN_FRONTEND=noninteractive echo deb http://cran.rstudio.com/bin/linux/debian jessie-cran3/ > /etc/apt/sources.list.d/rstudio.list
RUN DEBIAN_FRONTEND=noninteractive apt-key adv --keyserver keys.gnupg.net --recv-key 381BA480


# Install all packages
RUN DEBIAN_FRONTEND=noninteractive apt-get update -qq && apt-get install -y \
  build-essential \
  cmake \
  curl \
  default-jre \
  gcc-4.8 \
  graphviz \
  g++-4.8 \
  inkscape \
  libboost-all-dev \
  libtbb-dev \
  libxml2 \
  libxml2-dev \
  pandoc \
  r-base-dev \
  r-recommended \
  vim-common
# notes: inkscape, pandoc needed to build the documentation

# Install R packages (requires libxml2-dev)
RUN DEBIAN_FRONTEND=noninteractive Rscript -e 'source("http://www.bioconductor.org/biocLite.R"); biocLite(c("rjson", "EBSeq", "edgeR", "limma", "DESeq", "DESeq2", "Rsubread", "ggplot2"))'

# Install Python packages
RUN DEBIAN_FRONTEND=noninteractive pip install pip --upgrade
# Required by railroadtracks
RUN DEBIAN_FRONTEND=noninteractive pip install \
  cython \
  enum34 \
  flufl.enum \
  hieroglyph \
  jinja2 \
  markupsafe \
  matplotlib \
  networkx \
  notedown \
  numpy \
  pandas \
  pygraphviz \
  runipy \
  six \
  sphinx \
  sphinx_rtd_theme \
  tornado
# setup for htseq not declaring numpy. It must be installed in an earlier step
RUN DEBIAN_FRONTEND=noninteractive pip install htseq

# Install other tools

#
RUN DEBIAN_FRONTEND=noninteractive mkdir /usr/local/packages

# Bedtools2
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "https://github.com/arq5x/bedtools2/releases/download/v2.24.0/bedtools-2.24.0.tar.gz" && tar -xzf bedtools-2.24.0.tar.gz && cd bedtools2 && make && make install && cd ..

# Bowtie
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "http://downloads.sourceforge.net/project/bowtie-bio/bowtie/1.1.0/bowtie-1.1.0-src.zip" && unzip bowtie-1.1.0-src.zip && cd bowtie-1.1.0 && make && ln bowtie /usr/local/bin/ && ln bowtie-* /usr/local/bin/ && cd ..

# Bowtie2
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.3/bowtie2-2.2.3-source.zip" && unzip bowtie2-2.2.3-source.zip && cd bowtie2-2.2.3 && make && ln bowtie2 /usr/local/bin/ && ln bowtie2-* /usr/local/bin/ && cd ..

# BWA
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "http://downloads.sourceforge.net/project/bio-bwa/bwa-0.7.12.tar.bz2" && tar -xjf bwa-0.7.12.tar.bz2 && cd bwa-0.7.12 && make && ln bwa /usr/local/bin && cd ..

# Flux Simulator (requires default-jre)
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "http://sammeth.net/artifactory/barna/barna/barna.simulator/1.2.1/flux-simulator-1.2.1.tgz" && tar -xzf flux-simulator-1.2.1.tgz && cd flux-simulator-1.2.1/bin && ln flux-simulator /usr/local/bin/ && cd ../lib && ln *.jar /usr/local/lib/ && cd ../..

# GSNAP
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q "http://research-pub.gene.com/gmap/src/gmap-gsnap-2014-12-29.tar.gz" && tar -xzf gmap-gsnap-2014-12-29.tar.gz && cd gmap-2014-12-29 && ./configure --prefix=/usr/local/ && make && make install && cd ..

# Sailfish
# (deprecated - not included)

# Salmon (requires cmake, libtbb-dev)
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q https://github.com/COMBINE-lab/salmon/archive/6e30b92843587f75d3d4a01b0a3bcfbde4237c20.zip && unzip 6e30b92843587f75d3d4a01b0a3bcfbde4237c20.zip && cd salmon-6e30b92843587f75d3d4a01b0a3bcfbde4237c20 && mkdir -p build && cmake -DCMAKE_C_COMPILER=`which gcc` -DCMAKE_CXX_COMPILER=`which g++` -DCMAKE_INSTALL_PREFIX:PATH=/usr/local && make && make install && cd ..

# Samtools
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q http://downloads.sourceforge.net/project/samtools/samtools/0.1.19/samtools-0.1.19.tar.bz2 && tar -xjf samtools-0.1.19.tar.bz2 && cd samtools-0.1.19 && make && make razip && ln samtools /usr/local/bin/ && ln razip /usr/local/bin && ln libbam.a /usr/local/lib/ && mkdir /usr/local/include/bam && ln *.h /usr/local/include/bam && cd ..

# STAR (requires vim-common (xxd))
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q https://github.com/alexdobin/STAR/archive/STAR_2.4.1d.zip && unzip STAR_2.4.1d.zip && cd STAR-STAR_2.4.1d/source && make clean && make STAR && ln STAR /usr/local/bin/ && make clean && make STARlong && ln STARlong /usr/local/STARlong && cd ../..

# TopHat2 (requires gcc-4.8 and g++-4.8)
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages && wget -q https://ccb.jhu.edu/software/tophat/downloads/tophat-2.0.14.tar.gz && tar -xzf tophat-2.0.14.tar.gz && cd tophat-2.0.14 && CC=gcc-4.8 CXX=g++-4.8 ./configure --prefix=/usr/local && make && make install 

RUN DEBIAN_FRONTEND=noninteractive pip install git+https://github.com/Novartis/railroadtracks.git@version_0.4.x#egg=railroadtracks && cd /usr/local/packages && cd /usr/local/packages && git clone -b version_0.4.x git://github.com/Novartis/railroadtracks.git

# build railroadtracks documentation
RUN DEBIAN_FRONTEND=noninteractive cd /usr/local/packages/railroadtracks/doc && make -B notebooks && make html