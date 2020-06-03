FROM python:3  
RUN pip install telethon requests flask  
  
WORKDIR /app  
  
COPY . .  
  
CMD [ "python", "server.py" ]  
  
VOLUME [ "/tmp" ]  
  
EXPOSE 5000

