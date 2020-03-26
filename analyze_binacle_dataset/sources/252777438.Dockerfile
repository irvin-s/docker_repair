#################################################################  
# Dockerfile  
# File Author / Maintainer: cheng gong <512543469@qq.com>  
#################################################################  
  
FROM continuumio/miniconda  
  
MAINTAINER cheng gong <512543469@qq.com>  
  
RUN conda config --add channels defaults &&\  
conda config --add channels conda-forge &&\  
conda config --add channels r &&\  
conda config --add channels bioconda &&\  
conda update --all -y &&\  
conda install -y r-wgcna=1.51 &&\  
conda install -y -c luke-mino-altherr r-mice &&\  
git clone https://github.com/kaigu1990/wgcna.git  
  
#WORKDIR /wgcna  
#Rscript ./wgcna_proteome.R  
  
CMD ["/bin/bash"]  
  
  

