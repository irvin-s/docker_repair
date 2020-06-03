FROM node:10.7.0

ENV HOST 0.0.0.0
ENV PORT 80

RUN mkdir -p /app
COPY . /app
WORKDIR /app

RUN npm i yarn -g
RUN yarn install
RUN yarn run build
# Expose the app port
EXPOSE 80

CMD ["npm", "start"]
