FROM node:6
EXPOSE 4200
WORKDIR /app
ADD package.json /app
RUN npm install
ADD . /app
CMD ./node_modules/.bin/ng serve --host=0.0.0.0
