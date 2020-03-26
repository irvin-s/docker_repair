FROM telegraf:latest  
  
RUN apt-get update && apt-get install -y --force-yes lm-sensors

