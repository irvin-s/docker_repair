# Galaxy - Metagenomics  
FROM bgruening/galaxy-ngs-preprocessing:17.05  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND Galaxy Metagenomics  
  
ADD metagenomics.yaml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml && \  
/tool_deps/_conda/bin/conda clean --tarballs  

