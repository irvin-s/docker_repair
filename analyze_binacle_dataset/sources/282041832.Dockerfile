# build environment
FROM node:8.9.4 as builder

WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH

COPY . /usr/src/app
COPY ./src/prodConfig.json ./src/config.json

RUN yarn
RUN npm install react-scripts@1.1.1 -g --silent

RUN yarn run build

# production environment
FROM nginx:1.13.9-alpine
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]

# adapted from http://mherman.org/blog/2017/12/07/dockerizing-a-react-app/#.Wqsn9ZM-ck8
