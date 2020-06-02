FROM ubuntu
MAINTAINER Matt Erasmus <code@zonbi.org>
RUN apt-get update
RUN apt-get install -yq git python3-pip python3-pymongo mongodb libxml2-dev python3-lxml redis-server tmux
RUN git clone https://github.com/cve-search/cve-search.git /opt/cve-search
WORKDIR /opt/cve-search
RUN pip3 install -r requirements.txt
WORKDIR /root
COPY init.sh /root/init.sh
COPY tmux.sh /root/tmux.sh
RUN chmod 700 /root/init.sh /root/tmux.sh
