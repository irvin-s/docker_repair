FROM ubuntu:latest

RUN apt-get update
RUN apt-get install -y nodejs npm git
RUN ln -s /usr/bin/nodejs /usr/bin/node
RUN mkdir /data
RUN cd /data \
&& git clone -b dockerUpdate https://github.com/ToastyStoemp/Toasty.Chat
RUN cd /data/Toasty.Chat \
&& npm install
RUN apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY ./entrypoint.sh /
CMD ["bash", "./entrypoint.sh"]
