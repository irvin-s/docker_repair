# Galaxy - RNA structural analysis  
FROM quay.io/bgruening/galaxy-rna-seq:18.05  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND="RNA structural analysis"  
# Install tools  
ADD rna_structural_analysis.yml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml && \  
/tool_deps/_conda/bin/conda clean --tarballs --yes > /dev/null && \  
rm /export/galaxy-central/ -rf  

