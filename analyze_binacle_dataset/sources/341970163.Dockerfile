FROM node:6

RUN npm install -g bs-platform@2.2.2 create-react-app --unsafe-perm

RUN mkdir /app
WORKDIR /app
ADD . /app/
