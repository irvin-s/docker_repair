FROM python:2.7-alpine  
MAINTAINER Justin Barksdale "jusbarks@cisco.com"  
#RUN apk add --no-cache --virtual .build-deps \  
# git \  
# libmysqlclient-dev \  
# python \  
# python-pip \  
# RUN pip install --no-cache-dir \  
#RUN apk del .build-deps  
ADD . /app  
WORKDIR /app  
  
RUN pip install -r requirements.txt  
# RUN [ "chmod", "+x", "/agents/run.sh"]  
# CMD ["./agent/run.sh"]  
CMD [ "python", "./agents/chive_agent_aci.py" ]

