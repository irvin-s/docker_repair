FROM ubuntu:14.04

RUN apt-get update -y

# install system deps
RUN apt-get install -y git curl w3m

# install node
RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get install -y nodejs

# install rss monitor and edgar monitor
RUN git clone https://github.com/buzzfeed-openlab/rss-puppy.git /opt/rss-puppy
COPY . /opt/edgar-monitor

# install deps
RUN cd /opt/edgar-monitor; npm install
RUN cd /opt/rss-puppy; npm install

EXPOSE 7654

# run
CMD ["node", "/opt/rss-puppy/run.js", "/opt/edgar-monitor/config.json"]
