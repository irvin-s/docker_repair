
FROM node:argon
# Create app directory

ADD . /
ADD package.json package.json
ADD app.js app.js

RUN npm install
CMD ["node","app.js"]
