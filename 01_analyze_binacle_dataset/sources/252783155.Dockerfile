FROM ubuntu:15.10  
RUN apt-get update && apt-get install -y curl  
RUN echo >/etc/apt/sources.list.d/heroku.list \  
deb http://toolbelt.heroku.com/ubuntu ./  
RUN curl -sL https://toolbelt.heroku.com/apt/release.key | apt-key add -  
RUN apt-get update && apt-get install -y heroku-toolbelt ruby  
VOLUME /root /tmp  

