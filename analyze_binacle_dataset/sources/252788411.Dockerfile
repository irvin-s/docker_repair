FROM crossz/docker-phantomjs2  
RUN echo "Asia/Shanghai" > /etc/timezone  
ADD 500.js /opt/spider/  

