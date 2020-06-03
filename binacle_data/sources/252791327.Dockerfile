FROM python:3.6-slim  
  
COPY ./requirements.txt ./  
  
# Install dependenceis  
RUN apt-get -y update && \  
apt-get -y install gcc groff && \  
pip install -r requirements.txt && \  
apt-get -y purge gcc && \  
apt-get -y autoremove  
  
# Copy the latest version of the bot  
COPY ./discord_quote ./discord_quote  
  
# Change to working directory  
WORKDIR ./discord_quote/discord_quote/  
  
# Run the shell file  
CMD ["python", "discord_quote.py"]  

