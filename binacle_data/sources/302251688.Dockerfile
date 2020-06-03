FROM node
WORKDIR /address-service
COPY . /address-service
RUN npm install

CMD ["node", "index.js"]
EXPOSE 8090