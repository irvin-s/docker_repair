FROM google/dart

WORKDIR /app

ADD pubspec.yaml /app/
RUN pub get
ADD . /app/
RUN pub install

CMD []
ENTRYPOINT ["/usr/bin/dart", "/app/bin/server.dart"]
EXPOSE 8080