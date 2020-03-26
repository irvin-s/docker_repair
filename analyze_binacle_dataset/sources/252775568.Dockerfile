FROM ubuntu:trusty  
RUN apt-get update  
RUN apt-get install -y build-essential nodejs npm  
RUN ln -s $(which nodejs) /usr/bin/node  
RUN apt-get install -y spamassassin spamc  
RUN apt-get install -y rsyslog  
RUN apt-get install -y git curl python phantomjs  
RUN npm install -g mailin  
EXPOSE 25  
CMD [sudo mailin --webhook http://requestb.in/1dyxedu1]  

