FROM clifflu/sophos-av-npm

COPY ./guanyu /guanyu
WORKDIR /guanyu

RUN npm install --production && npm dedupe
RUN sed -i "s/<Email><Status>enabled/<Email><Status>disabled/" /opt/sophos-av/etc/savd.cfg

EXPOSE 3000

CMD ["npm", "run", "start"]
