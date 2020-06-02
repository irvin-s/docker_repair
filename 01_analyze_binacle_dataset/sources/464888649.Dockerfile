FROM node:8.12-alpine AS builder
RUN apk add --update make
WORKDIR /signal
COPY . ./
RUN make install
RUN make

####################################################################################################
## Image
####################################################################################################

FROM nginx:1.15-alpine as production-stage
COPY --from=builder /signal/dist /usr/share/nginx/signal
COPY ./nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
