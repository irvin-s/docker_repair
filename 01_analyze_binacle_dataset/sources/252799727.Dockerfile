FROM python:2.7.14-wheezy  
  
# Install ansible  
RUN pip install ansible==2.4.0.0  
  
# Install system dependencies  
RUN apt-get update  
RUN apt-get install rsync  
  
# Add possibility to have only one ssh agent running, to be  
# able to save ssh key passwords to use in multiple sessions  
RUN mkdir /synced_ssh_agent  
COPY run_ssh_agent.sh /synced_ssh_agent/  
  
# Define working directory.  
WORKDIR /app

