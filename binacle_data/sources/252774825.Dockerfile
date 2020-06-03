FROM python:3-alpine  
  
LABEL maintainer=battlecloud  
LABEL email=battlecloud@khast3x.club  
LABEL image=ctfr  
LABEL source=https://github.com/UnaPibaGeek/ctfr.git  
  
RUN apk add --no-cache git  
  
RUN git clone https://github.com/UnaPibaGeek/ctfr.git ctfr  
WORKDIR ctfr  
# Is a python requirements.txt present  
RUN pip install -r requirements.txt  
  
# Expose ports  
# Start tool  
VOLUME ["/loot"]  
COPY docker-entrypoint.sh .  
ENTRYPOINT ["./docker-entrypoint.sh"]  

