FROM egenius/node

ADD . /

RUN npm install --progress=false

ENTRYPOINT [ "node", "index.js" ]
