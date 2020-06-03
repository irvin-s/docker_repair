FROM node:10-alpine as builder

COPY package.json package-lock.json ./

## Storing node modules on a separate layer will prevent unnecessary npm installs at each build

RUN npm ci && mkdir /app && mv ./node_modules ./app

WORKDIR /app

COPY . .

RUN npm run build-dev

FROM nginx:alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
RUN nginx -t -c /etc/nginx/nginx.conf

COPY --from=builder /app/dist/ /dist/
