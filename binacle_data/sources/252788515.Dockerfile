FROM cryptic/node-and-python3  
  
RUN git clone https://github.com/cryptic-io/cryptic-bot.git  
RUN git clone https://github.com/tdryer/hangups.git  
  
ENV NODE_VERSION 0.10.36  
ENV HUBOT_HANGUPS_PYTHON /usr/local/bin/python  
  
WORKDIR /cryptic-bot  
RUN npm install  
# To get all the python dependencies  
RUN python node_modules/hubot-hangups/setup.py install  
  
# Get the latest version of hangups  
WORKDIR /hangups  
RUN rm /usr/local/lib/python3.4/site-packages/hangups-0.2.4-py3.4.egg  
RUN python setup.py install  
  
WORKDIR /cryptic-bot  
  
CMD ["bin/hubot", "-a","hangups","-n","cryptbot"]  

