FROM ufoym/deepo:cpu  
RUN apt-get -qq update && apt-get install -y \  
screen \  
unzip \  
python3-tk \  
nano  

