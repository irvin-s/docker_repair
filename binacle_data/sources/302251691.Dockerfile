FROM node
WORKDIR /graphql-service
COPY . /graphql-service
RUN npm install

CMD ["node", "index.js"]
EXPOSE 4000