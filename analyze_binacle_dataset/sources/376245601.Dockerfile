FROM tomcat:7

RUN apt-get update -y \
  && apt-get install -y --no-install-recommends	\
    build-essential autoconf curl gnupg apt-transport-https automake git \
  && apt-key adv --keyserver keys.gnupg.net --recv-key 6212B7B7931C4BB16280BA1306F90DE5381BA480 \
  && echo "deb https://cloud.r-project.org/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list \
  && apt-get update -y \
  && apt-get install -y --no-install-recommends \
    r-base r-base-dev r-recommended libtool supervisor \
  && apt-get install -y --no-install-recommends \
    libxml2-dev libcurl4-gnutls-dev gfortran libreadline-dev \
  && rm -rf /tmp/* /var/lib/apt/lists/*

#Intall ProtoBuf
RUN git clone https://github.com/dfci-cccb/protobuf.git \
  && cd protobuf \
  && ./autogen.sh \
  && ./configure --prefix=/usr \
  && make \
  && make check \
  && make install \
  && cd .. && rm -rf protobuf

#R Configure Repo URL
RUN echo 'options (repos="https://cloud.r-project.org/", download.file.method="libcurl");' >> /etc/R/Rprofile.site 

#R Intall Bioconductor Package
RUN echo 'source("https://bioconductor.org/biocLite.R");' >> /tmp/install_bioc.R \
  && echo "biocLite (c ('topGO', 'org.Hs.eg.db', 'org.Mm.eg.db', 'limma', 'DESeq', 'edgeR', 'ReactomePA', 'metagenomeSeq', 'DESeq2', 'impute', 'preprocessCore', 'multtest'));" >> /tmp/install_bioc.R \
  && Rscript /tmp/install_bioc.R && rm -rf /tmp/* /var/lib/apt/lists/*

#R Install CRAN Packages
RUN echo "install.packages (c ('Rserve', 'rafalib', 'amap', 'RProtoBuf', 'jsonlite', 'injectoR', 'WGCNA'));" >> /tmp/install_cran.R \
  && Rscript /tmp/install_cran.R && rm -rf /tmp/* /var/lib/apt/lists/*

EXPOSE 8080
EXPOSE 6311

ADD topgo /opt/data/topgo/domain/src/main/resources
RUN rm -rf /usr/local/tomcat/webapps/*
ADD mev.war /usr/local/tomcat/webapps/ROOT.war
ADD server.xml /usr/local/tomcat/conf/server.xml
ADD eval.R /opt/eval.R
ADD run.sh /opt/run.sh
ADD Rserve.conf /etc/Rserv.conf

CMD ["sh", "/opt/run.sh"]
