FROM google/dart-runtime-base

# google/dart-runtime boilerplate
WORKDIR /app
ADD pubspec.* /app/
# custom line:
ADD ./modules /app/modules
RUN pub get
ADD . /app/
RUN pub get --offline


CMD ["dart", "bin/server.dart", "--enable-vm-service"]
EXPOSE 8080
EXPOSE 8181