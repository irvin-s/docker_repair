FROM python:3.6-slim  
  
ARG ROOT=/usr/local/discord_bot  
  
ENV TOKEN=none  
  
COPY ./ $ROOT  
WORKDIR $ROOT  
  
RUN pip3 install -r requirements.txt  
  
CMD python3 start.py $TOKEN

