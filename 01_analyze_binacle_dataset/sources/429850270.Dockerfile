FROM node:4.2.0

EXPOSE 80
ENV NODE_ENV production

COPY package.json ./
RUN npm install
COPY . .

CMD ["npm", "start"]
