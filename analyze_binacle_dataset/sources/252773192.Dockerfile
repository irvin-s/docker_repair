# Galaxy - Phylogenetics  
FROM quay.io/bgruening/galaxy-ngs-preprocessing:18.05  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND Phylogenetics  
  
# Install tools  
ADD phylogenetics.yaml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml && \  
/tool_deps/_conda/bin/conda clean --tarballs  

