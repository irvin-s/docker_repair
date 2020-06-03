FROM python:3  
RUN pip install docker-py  
  
RUN mkdir -p /usr/src/agent  
WORKDIR /usr/src/agent  
  
# Bundle app source  
COPY . /usr/src/agent  
  
CMD [ "python", "agent.py" ]  

