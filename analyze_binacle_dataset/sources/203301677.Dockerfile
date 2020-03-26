FROM node:6.3.0

RUN mkdir -p /home/app
WORKDIR /home/app

COPY ./package.json /home/app/package.json
RUN npm install

COPY . /home/app

# Set development environment as default
ENV NODE_ENV development

EXPOSE 3000

CMD [ "npm", "run", "build" ]
