FROM elixir:1.3-slim

ARG APP
ARG VERSION


COPY rel/$APP/releases/$VERSION/docker-$APP-$VERSION.tar.gz /app.tar.gz
RUN tar -xzf /app.tar.gz

WORKDIR /releases/$VERSION
RUN ln -s /bin/$APP /app

EXPOSE 4000
ENTRYPOINT ["/app"]
CMD ["foreground"]