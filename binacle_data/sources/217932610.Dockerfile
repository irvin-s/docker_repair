FROM cnsa/iconv:latest

ARG VERSION

# COPY APP

RUN mkdir /app
WORKDIR /app

ENV APP_NAME "some_app"

COPY ./_build/prod/rel/$APP_NAME/releases/$VERSION/$APP_NAME.tar.gz /app/$APP_NAME.tar.gz
RUN tar -zxvf $APP_NAME.tar.gz > /dev/null 2>&1

WORKDIR /app/releases/$VERSION

# RUN

EXPOSE 4000

ENTRYPOINT ["./some_app.sh"]
CMD ["foreground"]
