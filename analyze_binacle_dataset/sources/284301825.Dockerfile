FROM node as builder
COPY src /app
RUN cd /app && yarn install
RUN cd /app && yarn run build

FROM alpine

COPY fui /bin/fui
COPY assets /assets
COPY --from=builder /app/build/ /assets/

CMD ["/bin/fui","--assets","/assets"]
