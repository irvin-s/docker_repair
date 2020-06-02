# Galaxy - Protease Prediction  
FROM quay.io/bgruening/galaxy:18.05  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND="Machine Learning"  
ADD ml.yaml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml  

