FROM node:8 as builder

WORKDIR /app

COPY package.json /app/

RUN npm install

COPY . /app/

ARG env=prod
RUN npm run build -- --prod --environment $env


# Stage 2
FROM nginx:1.13.3-alpine
COPY ./nginx-default.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/*
COPY --from=builder /app/dist/ /usr/share/nginx/html

