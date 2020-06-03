FROM node:11 as builder
WORKDIR /home/app
COPY package.json package-lock.json ./
RUN npm i
COPY . .
RUN npm run build

FROM nginx:alpine
LABEL maintainer="http://www.hasadna.org.il/"
COPY --from=builder /home/app/dist /usr/share/nginx/html/
COPY nginx/ /etc/nginx/
