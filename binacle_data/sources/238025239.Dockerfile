FROM pandeiro/lein:2.5.2

ADD project.clj /app
RUN lein deps

CMD ["run"]
