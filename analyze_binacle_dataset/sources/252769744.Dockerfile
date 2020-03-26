# This Docker image is meant to serve commonly used Ensembl Genomes  
# already cached via PyEnsembl. Any application that depends on  
# the pyensembl library can use this image to speed things up  
# as caching these genomes is a huge bottleneck for most applications  
  
FROM armish/pyensembl:0.9.4  
MAINTAINER B. Arman Aksoy <arman@aksoy.org>  
  
RUN cd $HOME && \  
export PATH="$HOME/miniconda/bin:$PATH" && \  
hash -r && \  
  
# Create our Conda environment and activate it  
conda create -y -n pyensembl-test python=3 && \  
echo "$PATH" && ls $HOME/miniconda/bin && \  
. activate pyensembl-test && \  
  
# Install some packages up-front  
conda install numpy scipy nose pandas matplotlib biopython && \  
  
# and install pyensembl  
pip install pyensembl && \  
  
# Cache all the genomes!  
pyensembl install \--release 54 \--species human && \  
pyensembl install \--release 75 \--species human && \  
pyensembl install \--release 77 \--species human && \  
pyensembl install \--release 83 \--species human && \  
pyensembl install \--release 84 \--species human && \  
pyensembl install \--release 67 \--species mouse && \  
pyensembl install \--release 84 \--species mouse  
  
## Remove  
RUN echo "All done!"  
## All done!  

