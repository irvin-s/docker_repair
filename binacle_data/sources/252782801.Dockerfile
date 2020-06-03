FROM node:latest  
MAINTAINER David Awad  
  
ENV HUBOT_FB_USERNAME=""  
ENV HUBOT_FB_PASSWORD=""  
EXPOSE 80  
RUN mkdir /hubot  
WORKDIR /hubot  
  
# copy user scripts to hubot script path  
COPY . /hubot/  
  
RUN npm install -g coffee-script  
RUN npm install hubot-messenger  
RUN npm install  
CMD ["/hubot/bin/hubot", "-a", "messenger"]  

