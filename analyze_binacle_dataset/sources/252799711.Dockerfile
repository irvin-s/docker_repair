FROM python:alpine  
MAINTAINER Diego Ruggeri <diego@ruggeri.net.br> (@diegor2)  
  
COPY src /var/local/redditbot  
WORKDIR /var/local/redditbot  
  
RUN pip3 install -r requirements.txt  
  
CMD [ "python", "bot.py" ]  

