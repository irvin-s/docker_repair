FROM node:8
RUN useradd --create-home -s /bin/bash tacmap
WORKDIR /home/tacmap
COPY . /home/tacmap
RUN rm -Rf /home/tacmap/node_modules
ADD package.json /tmp/package.json
RUN cd /tmp && npm install
RUN cp -a /tmp/node_modules /home/tacmap
RUN cd /home/tacmap
CMD node tacmap.js --public
EXPOSE 8080