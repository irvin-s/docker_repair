#FROM ipython/ipython
FROM jupyter/notebook
#MAINTAINER IPython Project <ipython-dev@scipy.org>
MAINTAINER Nate Olson <nolson@nist.gov>
#modified ipython/notebook

# Adding Bioinformatics Tools
RUN apt-get update
RUN apt-get install -y -q   \ 
                            #git \
                            automake \
                            #pkg-config \
                            curl \
                            wget \
                            #bwa \
                            unzip \
                            #zlib1g-dev \
                            libbz2-dev \
                            libncurses5-dev \
                            libyaml-dev \
                            openjdk-7-jdk \
                            openjdk-7-jre \
                            r-base \
                            r-base-dev \
                            r-recommended
RUN echo 'options(repos = list(CRAN = "http://cran.rstudio.com/"))' >> /etc/R/Rprofile.site

# install bowtie2 
# RUN wget http://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.2.2/bowtie2-2.2.2-linux-x86_64.zip;\
#     unzip bowtie2-2.2.2-linux-x86_64.zip && rm -rf bowtie2-2.2.2-linux-x86_64.zip;\
#     ln -s `pwd`/bowtie*/bowtie* /usr/local/bin

# install picard
# this also sets the jars as 'executable' and puts them in the path so they can be found with the 'which ' command - not working correctly
RUN wget https://github.com/broadinstitute/picard/releases/download/1.136/picard-tools-1.136.zip;\
    unzip picard-tools-1.136.zip && rm -rf picard-tools-1.136.zip;\
    chmod +x picard*/*.jar && ln -s `pwd`/picard*/*.jar /usr/local/bin/

# install htslib samtools and bcftools
RUN wget https://github.com/samtools/samtools/releases/download/1.2/samtools-1.2.tar.bz2;\
    tar -xaf samtools-1.2.tar.bz2 && rm -rf samtools-1.2.tar.bz2 ;\
    cd samtools-1.2;\
    make && ln -f -s `pwd`/* /usr/local/bin/ && cd ../

RUN wget https://github.com/samtools/bcftools/releases/download/1.2/bcftools-1.2.tar.bz2;\
    tar -xaf bcftools-1.2.tar.bz2 && rm -rf bcftools-1.2.tar.bz2 ;\
    cd bcftools-1.2;\
    make && ln -f -s `pwd`/bcftools /usr/local/bin/ && cd ../

# install Pilon
RUN wget https://github.com/broadinstitute/pilon/releases/download/v1.12/pilon-1.12.jar;\
    chmod +x pilon-1.12.jar; \
    ln -s `pwd`/pilon-1.12.jar /usr/local/bin/pilon.jar

# install bwa using github
RUN git clone git://github.com/lh3/bwa.git; \
    cd bwa; \
    make && ln -f -s `pwd`/bwa /usr/local/bin/ && cd ../

# install TMAP
RUN git clone git://github.com/iontorrent/TMAP.git; \
	cd TMAP; \
	git submodule init && git submodule update; \
	sh autogen.sh && ./configure && make; \
	make install && ln -f -s `pwd`/tmap /usr/local/bin/ && cd ../

# install sratoolkit
RUN wget http://ftp-trace.ncbi.nlm.nih.gov/sra/sdk/2.4.5/sratoolkit.2.4.5-ubuntu64.tar.gz &&\
        tar -xf sratoolkit.2.4.5-ubuntu64.tar.gz &&\
        rm -rf sratoolkit.2.4.5-ubuntu64.tar.gz;\
        ln -f -s `pwd`/sratoolkit.2.4.5-ubuntu64/bin/* /usr/local/bin/

# install fastqc
#RUN wget http://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.2.zip;\
#    unzip fastqc_v0.11.2.zip && cd FastQC;\
#    chmod +x fastqc;\
#    ln -sf `pwd`/fastqc /usr/local/bin/ && cd ../

# install varscan
RUN wget http://sourceforge.net/projects/varscan/files/VarScan.v2.3.7.jar;\
    chmod +x VarScan.v2.3.7.jar; \
    ln -s `pwd`/VarScan.v2.3.7.jar /usr/local/bin/ && cd ../

# install vcflib
RUN git clone --recursive https://github.com/ekg/vcflib.git; \
    cd vcflib; \
    make && ln -f -s `pwd`/bin/* /usr/local/bin/ && cd ../

# install bamstat
# RUN wget http://sourceforge.net/projects/bamstats/files/BAMStats-1.25.zip;\
#     unzip BAMStats-1.25.zip ;\
#     ln -f -s `pwd`/BAMStats-1.25/BAMStats-1.25.jar /usr/local/bin/BAMStats-1.25.jar && cd ../

# installing cement
RUN pip install joblib
RUN pip install pyYAML
RUN pip install sinchsms

VOLUME /pepr-data
WORKDIR /pepr-data

# EXPOSE 8888

# # You can mount your own SSL certs as necessary here
# # ENV PEM_FILE /key.pem
# # $PASSWORD will get `unset` within notebook.sh, turned into an IPython style hash
# ENV PASSWORD micro_rm_pw

# # ADD notebook.sh /
# # RUN chmod u+x /notebook.sh

# # CMD ["/notebook.sh"]

