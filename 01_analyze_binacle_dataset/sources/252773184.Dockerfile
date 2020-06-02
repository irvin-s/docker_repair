# Galaxy - Exome Sequencing Pipeline  
FROM bgruening/galaxy-ngs-preprocessing  
  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND Exome Sequencing  
ENV ENABLE_TTS_INSTALL True  
  
# Enable Conda dependency resolution  
ENV GALAXY_CONFIG_CONDA_AUTO_INSTALL=True \  
GALAXY_CONFIG_CONDA_AUTO_INIT=True  
  
# Install tools  
ADD exome_seq.yaml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml  

