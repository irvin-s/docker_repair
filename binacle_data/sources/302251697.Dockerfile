FROM node
WORKDIR /user-service
COPY . /user-service
RUN npm install

CMD ["node", "index.js"]
EXPOSE 8092