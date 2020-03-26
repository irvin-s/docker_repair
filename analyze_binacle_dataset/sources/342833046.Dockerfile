FROM node:10
WORKDIR /app
COPY package.json package-lock.json /app/
RUN npm install
ADD . /app
ENV NODE_ENV production
USER 1337
CMD npm start
