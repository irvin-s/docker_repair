FROM {{name}}-base AS builder
WORKDIR /app
COPY . /app
RUN lein build

FROM openjdk:8-alpine
WORKDIR /app

COPY --from=builder /app/target/{{name}}-standalone.jar /app/{{name}}-standalone.jar

CMD java -cp /app/{{name}}-standalone.jar clojure.main -m {{name}}.api.main