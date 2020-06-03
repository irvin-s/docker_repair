FROM caltha/protractor  
ENV DISPLAY_SIZE 1280x2200  
RUN apt-get update && apt-get install -y x11vnc  
RUN npm install lodash moment jasmine-reporters  
RUN mkdir ~/.vnc  
# Setup a password  
RUN x11vnc -storepasswd 1234 ~/.vnc/passwd  
ADD xvfb.conf /etc/supervisor/conf.d/  
ADD vnc.conf /etc/supervisor/conf.d/  
  

