FROM node:8
ENV NPM_CONFIG_LOGLEVEL warn
COPY web/ /

RUN npm install
RUN npm install -g webpack
RUN npm install -g serve
RUN npm run dist

CMD serve -s dist -p 8000
EXPOSE 8000