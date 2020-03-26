FROM node:8 as builder
WORKDIR /src
COPY aaf-enrollment /src

RUN yarn install && yarn build



FROM nginx

COPY docker/nginx-aaf-enrollment/nginx-app.conf /etc/nginx/conf.d/default.conf
COPY --from=builder /src/build  /usr/src/app/
RUN apt-get update && apt-get install -y openssl
COPY docker/nginx-aaf-enrollment/generate_certs.sh /
RUN chmod +x /generate_certs.sh
RUN /generate_certs.sh
CMD ["nginx", "-g", "daemon off;"]