# Base Image  
FROM alexiswl/containers:latest  
  
# Metadata  
LABEL base.image="biocontainers:latest"  
LABEL version="1"  
LABEL software="TopHat2"  
LABEL software.version="2.1.1"  
LABEL description="A spliced read mapper for RNA-Seq"  
LABEL website="http://ccb.jhu.edu/software/tophat/index.shtml"  
LABEL documentation="http://ccb.jhu.edu/software/tophat/index.shtml"  
LABEL license="GPLv3"  
LABEL tags="Genomics"  
  
# Maintainer  
MAINTAINER Alexis Lucattini <alexis.lucattini@agrf.org.au>  
  
RUN conda install -c bioconda tophat=2.1.1  
  
WORKDIR /data/  
  
ENTRYPOINT ["tophat2"]  

