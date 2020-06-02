FROM node:5
RUN mkdir -p /opt/cinabre && mkdir -p /opt/cinabre/volume
WORKDIR /opt/cinabre
ADD package.json /opt/cinabre/
RUN npm install
ADD . /opt/cinabre
CMD ["/opt/cinabre/docker/start.sh"]
EXPOSE 4873
VOLUME /opt/cinabre/volume
