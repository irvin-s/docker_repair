FROM debian:8

MAINTAINER Raquel Lopes Costa "quelopes@gmail.com"
EXPOSE 3838 7474 8787

# ===================
# --- Linux AND R ---
# ===================

RUN echo "deb http://cran.rstudio.com/bin/linux/debian jessie-cran3/" >> /etc/apt/sources.list && \
    echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list && \
    apt-key adv --keyserver keys.gnupg.net --recv-key 6212B7B7931C4BB16280BA1306F90DE5381BA480 && \
    apt-get -y update && \
    apt-get -y install r-base r-base-dev && \
    apt-get -y install libcurl4-openssl-dev libxml2-dev libssl-dev libpng-dev && \
    apt-get -y install -t jessie-backports ca-certificates-java openjdk-8-jre-headless && \
    apt-get -y install wget gdebi-core openjdk-8-jdk curl && \
    apt-get -y clean
RUN /usr/sbin/update-java-alternatives -s java-1.8.0-openjdk-amd64

# ======================================
# --- INSTALL BIOCONDUCTOR AND RNEO4J---
# ======================================
RUN R -e "source(\"http://bioconductor.org/biocLite.R\"); biocLite()" && \
    R -e "source(\"http://bioconductor.org/biocLite.R\"); biocLite(c(\"GOstats\",\"hgu133plus2cdf\",\"hgu133plus2frmavecs\",\"hgu133acdf\",\"hgu133a2cdf\",\"hugene10stv1cdf\",\"affy\",\"impute\",\"Biobase\",\"limma\",\"org.Mmu.eg.db\",\"org.Mm.eg.db\",\"org.Rn.eg.db\",\"genefilter\",\"org.Hs.eg.db\",\"ggplot2\",\"igraph\",\"VennDiagram\",\"gplots\", \"fpc\",\"stringr\",\"WGCNA\",\"dynamicTreeCut\",\"frma\",\"inSilicoDb\",\"inSilicoMerging\"))" && \
    R -e "install.packages('RNeo4j',repos='https://cran.rstudio.com/', clean=TRUE)"

# =======================
# --- INSTALL RSTUDIO ---
# =======================
RUN VER=$(wget --no-check-certificate -qO- https://s3.amazonaws.com/rstudio-server/current.ver) && \
    wget https://download2.rstudio.org/rstudio-server-${VER}-amd64.deb && \
    gdebi --non-interactive rstudio-server-${VER}-amd64.deb && \
    rm rstudio-server-${VER}-amd64.deb && \
    useradd -m rstudio && \
    echo "rstudio:rstudio" | chpasswd && \
    apt-get -y clean

# =====================
# --- INSTALL NEO4J ---
# =====================
RUN wget -O neo4j.tar.gz https://neo4j.com/artifact.php?name=neo4j-community-3.0.6-unix.tar.gz && \
    cd /usr/local; tar xvfz /neo4j.tar.gz; ln -s neo4j-community-3.0.6 neo4j && \
    rm /neo4j.tar.gz && \
    sed -i -e "s/#dbms.connector.http.address/dbms.connector.http.address/" /usr/local/neo4j/conf/neo4j.conf


# =================================
# --- BUILD BACKGROUND DATABASE ---
# =================================
ADD import.cql /var/tmp/
ADD DataGraph/data.csv //usr/local/neo4j/data/databases/graph.db/import/
ADD DataGraph/PPI.csv.gz //usr/local/neo4j/data/databases/graph.db/import/
ADD DataGraph/taxon.csv //usr/local/neo4j/data/databases/graph.db/import/
RUN gunzip -f /usr/local/neo4j/data/databases/graph.db/import/PPI.csv.gz

RUN /usr/local/neo4j/bin/neo4j start && \
    sleep 40 && \
    echo "neo4j:SHA-256,614976D15DE5DDAEB1A60CE58654586D8F1589AD71FE442B243767E8AB4A065C,A924AB72EA3DC4A302D9E369E2363116:" > /usr/local/neo4j/data/dbms/auth && \
    /usr/local/neo4j/bin/neo4j stop && \
    /usr/local/neo4j/bin/neo4j-shell -v -path /usr/local/neo4j/data/databases/graph.db -config /usr/local/neo4j/conf/neo4j.conf -file /var/tmp/import.cql && \
    rm -rf /usr/local/neo4j/data/databases/graph.db/neostore.transaction.db.*

# =============
# --- Shiny ---
# =============
RUN wget --no-verbose https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/VERSION -O "version.txt" && \
    VERSION=$(cat version.txt)  && \
    wget --no-verbose "https://s3.amazonaws.com/rstudio-shiny-server-os-build/ubuntu-12.04/x86_64/shiny-server-$VERSION-amd64.deb" -O ss-latest.deb && \
    gdebi --non-interactive ss-latest.deb && \
    rm -f version.txt ss-latest.deb && \
    R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/', clean=TRUE)" && \
    apt-get -y clean
RUN R -e "install.packages(c('shinydashboard','shiny','shinythemes','RNeo4j','visNetwork','ggplot2','data.table','networkD3','igraph','shinyBS','RColorBrewer','devtools','d3heatmap'), repos='https://cran.rstudio.com/', clean=TRUE)"

#RUN wget -O RDataTracker.tar.gz http://harvardforest.fas.harvard.edu/data/p09/hf091/hf091-01-RDataTracker_2.24.0.tar.gz && \
#    R CMD INSTALL RDataTracker.tar.gz && \
#    rm RDataTracker.tar.gz

# Github version packages -- RDataTracker
RUN R -e " \
devtools::install_github('End-to-end-provenance/RDataTracker'); \
"

COPY shiny-server.sh /usr/bin/shiny-server.sh
RUN chmod 755 /usr/bin/shiny-server.sh
COPY GennetShiny /srv/shiny-server/gennet


# =========================
# --- BUILD THE MODULES ---
# =========================
USER rstudio
RUN mkdir /home/rstudio/Module-A
RUN mkdir /home/rstudio/Annotation
RUN mkdir /home/rstudio/Data
RUN mkdir /home/rstudio/Results

# ------------------
# --- Annotation ---
# ------------------
# Affymetrix
ADD Annotation/GPL570.txt /home/rstudio/Annotation/
ADD Annotation/GPL571.txt /home/rstudio/Annotation/
ADD Annotation/GPL96.txt /home/rstudio/Annotation/
ADD Annotation/GPL6244.txt /home/rstudio/Annotation/
ADD Annotation/GPL3535.txt /home/rstudio/Annotation/
ADD Annotation/GPL6246.txt /home/rstudio/Annotation/
ADD Annotation/GPL1261.txt /home/rstudio/Annotation/
ADD Annotation/GPL570.txt /home/rstudio/Annotation/
ADD Annotation/GPL1355.txt /home/rstudio/Annotation/

# ----------------------
# --- Pre Processing ---
# ----------------------
ADD Parameters.R /home/rstudio/

ADD Module-A/ModuleProcessingShiny.R /home/rstudio/Module-A/
ADD Module-A/Dependences.R /home/rstudio/Module-A/
ADD Module-A/ModuleProcessing.R /home/rstudio/Module-A/
ADD Module-A/cNodeExperiment.R /home/rstudio/Module-A/
ADD Module-A/cNodeValues.R /home/rstudio/Module-A/
ADD Module-A/Pre_Raw.R /home/rstudio/Module-A/
ADD Module-A/Pre_eSet.R /home/rstudio/Module-A/
ADD Module-A/Pre_Limma.R /home/rstudio/Module-A/
ADD Module-A/Pre_PosLimma.R /home/rstudio/Module-A/
ADD Module-A/MyStandardise.R /home/rstudio/Module-A/
ADD Module-A/Enrichment_GOStat2.R /home/rstudio/Module-A/
ADD Module-A/HeatMap3.R /home/rstudio/Module-A/
ADD Module-A/Pop_enrichment.R /home/rstudio/Module-A/
ADD Module-A/Clust_pop.R /home/rstudio/Module-A/
ADD Module-A/Clusterization.R /home/rstudio/Module-A/
ADD Module-A/GraphDataPersist.R /home/rstudio/Module-A/
ADD Module-A/PowerDetec.R /home/rstudio/Module-A/
ADD Module-A/AmdDetec.R /home/rstudio/Module-A/

USER root
CMD chmod -R 777 /home/rstudio && /usr/lib/rstudio-server/bin/rserver --server-daemonize=1 && \
    /usr/local/neo4j/bin/neo4j start && sleep 20 && /usr/bin/shiny-server.sh

