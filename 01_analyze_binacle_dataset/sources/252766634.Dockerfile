FROM python:3.4-alpine  
  
ENV MOVIE_NAME <MOVIE_NAME>  
ENV MOVIE_URL <MOVIE_URL>  
ENV SLACK_WEBHOOK_URL <slack webhook url>  
  
WORKDIR /app  
  
ADD /src /app  
  
RUN pip3 install requests  
  
ENTRYPOINT python app.py

