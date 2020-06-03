# Node.js 8.9.1  
# Prepped to support Chrome Headless  
FROM node:9  
# Prep for Headless chrome  
ADD ./chrome.sh /  
RUN chmod +x /chrome.sh && sh /chrome.sh  
RUN apt-get install psmisc

