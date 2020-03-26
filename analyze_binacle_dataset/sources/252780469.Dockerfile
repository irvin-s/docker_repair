FROM linuxserver/radarr  
MAINTAINER b3vis  
# Add sickbeard_mp4_automator dependancies  
RUN apt-get update && apt-get install -y \  
git \  
python-setuptools \  
python-pip \  
ffmpeg \  
&& \  
pip install --quiet --upgrade pip \  
&& \  
pip install --quiet \  
requests \  
requests[security] \  
requests-cache \  
babelfish \  
"guessit<2" \  
stevedore==1.19.1 \  
"subliminal<2" \  
qtfaststart  

