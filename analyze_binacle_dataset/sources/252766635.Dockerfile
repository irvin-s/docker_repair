FROM python:3.4-alpine  
  
ENV USERNAME your_username  
ENV CONSUMER_KEY your_consumer_key  
ENV CONSUMER_SECRET your_consumer_secret  
ENV ACCESS_TOKEN your_access_token  
ENV ACCESS_SECRET your_access_secret  
  
WORKDIR /app  
  
ADD /src /app  
  
RUN pip3 install tweepy  
  
ENTRYPOINT python app.py

