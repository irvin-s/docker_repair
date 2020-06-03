FROM dockerfile/nodejs  
  
# Install base packages  
RUN npm install -g hubot@2.6.0 coffee-script redis  
  
# Create new hubot and setup for irc.  
RUN cd /root && \  
hubot --create myhubot && \  
cd myhubot && \  
npm install hubot-irc --save && \  
npm install nodepie underscore xml2js cron emailjs sugar --save && \  
npm install  
  
# Set environment variables  
ENV TZ Asia/Seoul  
ENV HUBOT_IRC_NICK hubot  
ENV HUBOT_IRC_PORT 6667  
ENV HUBOT_IRC_ROOMS #general,#random,#sandbox,#d7  
ENV HUBOT_IRC_SERVER castisdev.irc.slack.com  
ENV HUBOT_IRC_UNFLOOD 500  
ENV HUBOT_IRC_USESSL 1  
ENV HUBOT_JENKINS_URL http://d7.mnpk.org/jenkins  
ENV HUBOT_JIRA_URL http://d7.mnpk.org/jira  
ENV REDISTOGO_URL redis://172.17.42.1:6379/hubot  
  
# HTTP Listener port 9009  
ENV PORT 9009  
EXPOSE 9009  
# Add custum scripts  
ADD hubot-scripts.json /root/myhubot/hubot-scripts.json  
ADD scripts/*.coffee /root/myhubot/scripts/  
  
# Run hubot("-a irc")  
WORKDIR /root/myhubot  
ENTRYPOINT ["/root/myhubot/bin/hubot", "-a", "irc"]  
CMD ["-n", "hubot"]  

