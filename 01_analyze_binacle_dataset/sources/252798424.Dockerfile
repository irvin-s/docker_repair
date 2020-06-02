FROM bioconductor/release_core  
  
MAINTAINER Dennis Hazelett "dennis.hazelett at csmc.edu"  
RUN DEBIAN_FRONTEND=noninteractive apt-get update  
## rtracklayer depends:  
RUN apt-get install -y libxml2-dev libcurl4-openssl-dev  
  
RUN R -e "biocLite('rtracklayer')"  
  
RUN su rstudio; cd /home/rstudio \  
&& git clone https://bitbucket.org/dennishazelett/footprint \  
&& mv footprint/data . \  
&& mv footprint/promoter.no_utr3.no_exon.bed . \  
&& rm -rf footprint  
  
WORKDIR /home/rstudio  
  
RUN mv data/config/footprint.sh /usr/bin/footprint \  
&& chmod +x /usr/bin/footprint  
  
ENTRYPOINT ["footprint"]  

