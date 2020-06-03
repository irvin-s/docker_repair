FROM clojure

COPY . /app
WORKDIR /app

RUN lein deps
