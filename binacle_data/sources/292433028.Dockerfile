FROM node

COPY package.json package-lock.json tsconfig.json tslint.json /app/
RUN cd /app && npm install
COPY src/ /app/src/
RUN cd /app && npm run build

CMD ["/usr/local/bin/node", "/app/build/index.js"]
