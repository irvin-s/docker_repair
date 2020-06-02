FROM node:8
COPY . /frontend
WORKDIR /frontend
EXPOSE 3000
RUN npm install
ENTRYPOINT ["npm", "start"]
