FROM python:3.6  
RUN apt-get update -qq && apt-get install -yqq curl  
RUN curl -sL https://deb.nodesource.com/setup_9.x | bash  
RUN apt-get install -yqq nodejs build-essential  
RUN apt-get clean -y  
  
RUN npm install gulp -g

