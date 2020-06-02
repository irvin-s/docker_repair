# spider-mzitu
# VERSION               1.0.0

FROM daocloud.io/node:7
LABEL maintainer owen-carter

COPY . /app
WORKDIR /app

RUN npm --registry=https://registry.npm.taobao.org --disturl=https://npm.taobao.org/dist install
RUN npm install

#ENTRYPOINT ["./entrypoint.sh"]
CMD ["npm", "run","app"]
