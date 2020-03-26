# Galaxy - Protease Prediction  
FROM bgruening/galaxy-stable:17.05  
MAINTAINER Björn A. Grüning, bjoern.gruening@gmail.com  
  
ENV GALAXY_CONFIG_BRAND="Protease Prediction" \  
ENABLE_TTS_INSTALL=True  
  
ADD protease_prediction.yaml $GALAXY_ROOT/tools.yaml  
RUN install-tools $GALAXY_ROOT/tools.yaml  

