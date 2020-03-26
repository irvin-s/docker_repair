FROM python:2.7-onbuild  
MAINTAINER Keaton Choi "keaton@dailyhotel.com"  
COPY relay.py ./  
COPY channel_selector.json ./  
  
CMD ["python", "./relay.py"]  

