FROM node:8.11.4-alpine
ARG ENV_FLAG="--development"
WORKDIR /app
COPY ./package.json /app/package.json
COPY ./package-lock.json /app/package-lock.json
RUN npm install ${ENV_FLAG}
COPY . /app
