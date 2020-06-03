FROM fedora
LABEL maintainer "xuning.wang@bms.com"
CMD bash
RUN dnf install -y wget
RUN dnf install -y which
RUN dnf install -y procps
RUN dnf install -y bzip2
RUN dnf install -y gcc
RUN dnf install -y git
RUN dnf install -y redhat-rpm-config
RUN dnf install -y perl
RUN dnf install -y python
RUN dnf install -y java
RUN dnf install -y R
RUN dnf install -y python-devel
RUN dnf install -y cpanminus
RUN dnf install -y dos2unix

#install perl modules
RUN cpanm https://cpan.metacpan.org/authors/id/R/RS/RSAVAGE/Config-Tiny-2.23.tgz 
RUN cpanm https://cpan.metacpan.org/authors/id/J/JM/JMCNAMARA/Excel-Writer-XLSX-0.95.tar.gz 
RUN cpanm https://cpan.metacpan.org/authors/id/I/IS/ISHIGAKI/JSON-2.94.tar.gz
RUN cpanm http://search.cpan.org/CPAN/authors/id/M/MI/MIKEB/Spreadsheet-XLSX-0.15.tar.gz 

#install pysamstats
RUN pip install pysam==0.8.4
RUN pip install pysamstats==0.24.3

# install ABRA 
RUN wget https://github.com/mozack/abra/releases/download/v0.97/abra-0.97-SNAPSHOT-jar-with-dependencies.jar \
	-O /usr/local/bin/abra-0.97-SNAPSHOT-jar-with-dependencies.jar

# install BWA
RUN wget https://sourceforge.net/projects/bio-bwa/files/bwa-0.7.15.tar.bz2/download --no-check-certificate -O bwa-0.7.15.tar.bz2 \
	&& tar xvfj bwa-0.7.15.tar.bz2 \
	&& cd bwa-0.7.15 \
	&& make \
	&& mv bwa /usr/local/bin \
	&& cd .. \
	&& rm -r bwa-0.7.15* 

# install samtools
RUN wget https://sourceforge.net/projects/samtools/files/samtools/1.3.1/samtools-1.3.1.tar.bz2/download -O samtools-1.3.1.tar.bz2 \
	&& tar xvfj samtools-1.3.1.tar.bz2 \
	&& cd samtools-1.3.1 \
	&& ./configure --without-curses \
	&& make \
	&& mv samtools /usr/local/bin \
	&& cd .. \
	&& rm -r samtools-1.3.1*

# install bedtools
RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.25.0/bedtools-2.25.0.tar.gz \
	&& tar xvfz bedtools-2.25.0.tar.gz \
	&& cd bedtools2 \
	&& make \
	&& mv bin/bedtools /usr/local/bin \
	&& cd .. \
	&& rm -r bedtools*

# install prinseq
RUN wget https://sourceforge.net/projects/prinseq/files/standalone/prinseq-lite-0.20.4.tar.gz/download \
	--no-check-certificate -O prinseq-lite-0.20.4.tar.gz \
	&& tar xvfz prinseq-lite-0.20.4.tar.gz \
	&& mv prinseq-lite-0.20.4/prinseq-lite.pl /usr/local/bin \
	&& chmod +x /usr/local/bin/prinseq-lite.pl \
	&& rm -r prinseq-lite-0.20.4*

# install flash
RUN git clone https://github.com/dstreett/FLASH2.git \
	&& cd FLASH2 \
	&& make \
	&& mv flash2 /usr/local/bin \
	&& cd .. \
	&& rm -r FLASH2

# install R packages
RUN echo "r <- getOption('repos'); r['CRAN'] <- 'http://cran.us.r-project.org'; options(repos = r);" > ~/.Rprofile
RUN Rscript -e "install.packages('ggplot2')"
RUN Rscript -e "install.packages('naturalsort')"

# clone crispr-dav pipeline
RUN git clone https://github.com/pinetree1/crispr-dav.git \
	&& cp /crispr-dav/Docker/conf.txt /crispr-dav/Examples/example1 \
	&& cp /crispr-dav/Docker/conf.txt /crispr-dav/Examples/example2 \
	&& cp /crispr-dav/Docker/conf.txt /crispr-dav/

