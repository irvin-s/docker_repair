FROM python:2.7-alpine  
MAINTAINER Justin Barksdale "jusbarks@cisco.com"  
ADD . /app  
  
WORKDIR /app  
  
RUN pip install -r requirements.txt  
  
CMD [ "python", "./agents/chive_agent_ucs.py" ]

