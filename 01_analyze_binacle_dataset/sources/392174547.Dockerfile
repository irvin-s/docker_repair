# Build
# -----------------------------------------------------------------------------

FROM alpine:3.9 AS build

LABEL maintainer="Michael Dippery <michael@monkey-robot.com>"

RUN apk add --update bash curl openjdk8-jre

WORKDIR /usr/local/bin
RUN curl -O https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein
RUN chmod a+x lein

COPY . /app
WORKDIR /app
RUN lein uberjar


# Application
# -----------------------------------------------------------------------------

FROM alpine:3.9

ENV DATABASE_URL postgres://localhost:5432

RUN apk add --update openjdk8-jre

COPY --from=build /app/target/uberjar/stackim-standalone.jar /app/stackim-standalone.jar
WORKDIR /app

EXPOSE 5000
CMD ["java", "-jar", "/app/stackim-standalone.jar"]
