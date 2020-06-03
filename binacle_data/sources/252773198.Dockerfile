# Galaxy - RNA-Seq  
FROM bgruening/galaxy-stable:17.09  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND "Sequence Tools"  
# Install tools  
COPY sequence-tools.yml $GALAXY_ROOT/tools.yaml  
  
RUN install-tools $GALAXY_ROOT/tools.yaml && \  
/tool_deps/_conda/bin/conda clean --tarballs  

