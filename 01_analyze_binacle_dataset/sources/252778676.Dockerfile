FROM python:3.6.2-alpine3.6  
RUN pip install python-telegram-bot  
  
WORKDIR .  
  
COPY list-bot.py .  
  
CMD python list-bot.py

